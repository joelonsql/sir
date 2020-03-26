library(tidyverse)
library(lubridate)
library(plotly)

# Helper function to show p-values
signif.num <- function(x) {
  symnum(x, corr = FALSE, na = FALSE, legend = FALSE,
         cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), 
         symbols = c("***", "**", "*", ".", " "))
}

# Data sources:
# icu: https://portal.icuregswe.org/siri/report/vtfstart-corona
# deaths: https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv#L207

first_date <- as.Date("2020-03-05")
icu    <-        c(2,1,2,0,2,0,1,3,6,7,6,3,15,13,23,16,27,40,38)
deaths <- diff(c(0,0,0,0,0,0,1,1,1,2,3,6,7,10,11,16,20,21,25,36))

stopifnot(length(icu) == length(deaths))

days <- 1:length(icu)

# Assume exponential curve
model <- lm(log2(cumsum(icu+deaths)) ~ days);

model_summary <- summary(model)

future_days <- length(icu):(length(icu)+7)

forecast <- diff(as.integer(2 ^ (future_days * model$coefficients[2] + model$coefficients[1])))

data <- rbind(
  data.frame(day = days, type = "Nya intensivvård", count = icu),
  data.frame(day = days, type = "Nya döda", count = deaths),
  data.frame(day = (length(icu)+1):(length(icu)+7), type = "Prognos behov nya intensivvård", count = forecast)
)

data$day <- first_date + data$day

plot <- ggplot(data, aes(x=day)) +
  geom_col(aes(y=count, fill=type)) +
  geom_text(aes(y = count, label = count),
            vjust = "inward", hjust = "inward",
            show.legend = FALSE, check_overlap = TRUE) +
  geom_vline(xintercept = Sys.Date()) +
  theme_minimal() +
  ggtitle("Antal nyinskrivna intensivvårdtillfällen och döda pga Coronavirus i Sverige",
          subtitle=paste(
            "Rådata från:",
            "\nhttps://portal.icuregswe.org/siri/report/vtfstart-corona",
            "\nhttps://github.com/CSSEGISandData/COVID-19",
            "\nAdjusted R-squared:", round(model_summary$adj.r.squared,3)
          )
  ) +
  ylab("Människoliv") +
  xlab("Datum")

print(plot)

print(model_summary)
