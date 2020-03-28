library(tidyverse)
library(plotly)

start_date <- as.Date("2020-03-10") # Date before first death
deaths_data <- c(1,1,1,2,3,6,7,10,11,16,20,21,25,36,62,77,105)
population <- 10333456
deceased <- population * 0.001
exponent <- 3.62749 # based on 4PL curve-fitting of Hubei death data

f <- function(x,c) {
  deceased + (1 - deceased)/(1 + (x/c)^exponent)
}
model <- nls(
  formula = y ~ f(x,c),
  data = data.frame(x=1:length(deaths_data), y=deaths_data),
  start = list(c=50)
)
model_summary <- summary(model)
c <- as.integer(model_summary$coefficients["c",1])

data <- data.frame(day=integer(), deaths=integer(), predict=integer())
for (x in 1:(c*2)) {
  data <- add_row(data, day=x, deaths=deaths_data[x], predict=round(f(x,c)))
}

data$day <- start_date + data$day

#ggplot(data, aes(x=day)) +
#  geom_point(aes(y=deaths, color="Antal döda")) +
#  geom_line(aes(y=predict, color="Prognos")) +
#  scale_y_log10() +
#  theme_minimal() +
#  geom_vline(xintercept = start_date+length(deaths_data)) +
#  ggtitle("COVID-19 dödskurva Sverige")

inflection_date <- start_date + c

data %>%
  plot_ly(
    x = ~day,
    y = ~predict,
    color = "Prognos",
    type = "scatter",
    mode = "lines"
  ) %>%
  add_markers(y = ~deaths, color="Historik") %>%
  layout(
    title = paste(
      "COVID-19 - Estimerad dödskurva - Sverige",
      "\nInflektionspunkt:", inflection_date,
      "Prognos", Sys.Date()+1, ":", filter(data,day==Sys.Date())$predict
    ),
    yaxis = list(title="Antal döda", type="log"),
    xaxis = list(title=paste("Skapad",Sys.Date()))
  ) %>%
  add_segments(x = inflection_date, xend = inflection_date, y = 0, yend = deceased, showlegend = FALSE)


