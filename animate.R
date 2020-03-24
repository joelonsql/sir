library(plotly)

signif.num <- function(x) {
  symnum(x, corr = FALSE, na = FALSE, legend = FALSE,
         cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), 
         symbols = c("***", "**", "*", ".", " "))
}

data <- read_csv("time_series_covid19_deaths_global.csv") %>%
  rename(Province = "Province/State",
         CountryRegion = "Country/Region") %>%
  pivot_longer(-c(Province,CountryRegion,Lat,Long), names_to = "Date", values_to = "NDeaths") %>%
  mutate(Date = mdy(Date)) %>%
  group_by(CountryRegion, Date) %>%
  summarise(NDeaths = sum(NDeaths)) %>%
  ungroup() %>%
  mutate(Day = as.integer(Date - min(Date))) %>%
  inner_join(
    read_csv("populations.csv", col_names=c("CountryRegion","Population")),
    by = "CountryRegion"
  ) %>%
  filter(Population > 1000000)

data$Deaths <- data$NDeaths / data$Population

i <- 0

all_data <- data.frame()


days <- max(data$Date)-min(data$Date)-7

last_actual_date <- max(data$Date)

deaths_per_capita_and_rate <- data.frame(Date=character(),Country=character(),DeathsPerCapita=double(),DeathRate=double(),NDeaths=integer())

for (d in days:0) {
  for (country in unique(data$CountryRegion)) {
    skip <- 0
    end_date <- last_actual_date - d
    country_data <- data %>% filter(CountryRegion == country, Deaths > 0, Date > end_date - 7, Date < end_date)
    if (count(country_data) < 3) {
      deaths_per_capita_and_rate <- add_row(deaths_per_capita_and_rate,
                                            Date=as.character(end_date),
                                            Country=country,
                                            DeathsPerCapita=0,
                                            DeathRate=0,
                                            NDeaths=0
      )
      next
    }
    if (min(country_data$Deaths) == max(country_data$Deaths)) {
      deaths_per_capita_and_rate <- add_row(deaths_per_capita_and_rate,
                                            Date=as.character(end_date),
                                            Country=country,
                                            DeathsPerCapita=0,
                                            DeathRate=0,
                                            NDeaths=0
      )
      next
    }
    country_data$Day <- country_data$Day - min(country_data$Day)

    model <- lm(log2(Deaths) ~ Day, country_data)
    model_summary <- summary(model)
    p_values <- sapply(model_summary$coefficients[,4],signif.num)
    
    print(paste(country, "R²adj", round(model_summary$adj.r.squared,2), "Coefficients",
                paste(
                  names(p_values),
                  model_summary$coefficients[,1],
                  p_values,
                  sep=" ",
                  collapse=" ; "
                )
    ))
    
    deaths_per_capita_and_rate <- add_row(deaths_per_capita_and_rate,
                                          Date=as.character(end_date),
                                          Country=country,
                                          DeathsPerCapita=tail(country_data,1)$Deaths,
                                          DeathRate=model_summary$coefficients[,1]["Day"],
                                          NDeaths=tail(country_data,1)$NDeaths,
    )
  }
}

deaths_per_capita_and_rate %>%
  plot_ly(
    x = ~DeathsPerCapita,
    y = ~DeathRate,
    color = ~Country,
    text = ~Country,
    size = ~NDeaths,
    frame = ~Date,
    type = "scatter",
    mode = "text"
  ) %>%
  layout(
    title = "COVID-19 death rate and deaths per capita",
    xaxis = list(type="log",range=c(log10(0.00000001),log10(0.001)))
  )

