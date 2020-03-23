library(tidyverse)
library(lubridate)
library(plotly)

# Helper function to show p-values
signif.num <- function(x) {
  symnum(x, corr = FALSE, na = FALSE, legend = FALSE,
         cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1), 
         symbols = c("***", "**", "*", ".", " "))
}

# Daily data from: https://portal.icuregswe.org/siri/report/vtfstart-corona
data <- data.frame(Dag = 1:17, IVAFall = cumsum(c(2,1,2,0,2,0,1,3,6,7,6,4,14,9,18,10,6)))

# Assume exponential curve
model <- lm(log2(IVAFall) ~ Dag, data);

model_summary <- summary(model)

data$Model <- as.integer(2 ^ (data$Dag * model$coefficients[2] + model$coefficients[1]))

data$Prediction <- NA

# Predict next 7 days
for (d in 18:24) {
  data <- add_row(
    data,
    Dag=d,
    Prediction=as.integer(2 ^ (d * model$coefficients[2] + model$coefficients[1])),
    Model=as.integer(2 ^ (d * model$coefficients[2] + model$coefficients[1]))
  )
}

p_values <- sapply(model_summary$coefficients[,4],signif.num)

data$Dag <- as.Date("2020-03-05") + data$Dag

ggplot(data, aes(x=Dag)) +
  geom_point(aes(y=IVAFall, color="Historik")) +
  geom_line(aes(y=Model, color="Modell")) +
  geom_point(aes(y=Prediction, color="Prognos")) +
#  geom_ribbon(
#    aes(
#      ymin = Model - 2 * 2^model_summary$sigma,
#      ymax = Model + 2 * 2^model_summary$sigma,
#      fill="Modell"
#    ), alpha = 0.3, show.legend = FALSE) +
  scale_color_discrete(aesthetics = c("color", "fill")) +
  geom_vline(xintercept = Sys.Date()) +
  geom_text(aes(y = IVAFall, label = IVAFall),
            vjust = "inward", hjust = "inward",
            show.legend = FALSE, check_overlap = TRUE) +
  geom_text(aes(y = Prediction, label = Prediction),
            vjust = "inward", hjust = "inward",
            show.legend = FALSE, check_overlap = TRUE) +
  theme_minimal() +
  ggtitle("Antal nyinskrivna intensivvårdtillfällen med Coronavirus i Sverige (kumulativt)",
    subtitle=paste(
      "Rådata från: https://portal.icuregswe.org/siri/report/vtfstart-corona"
    )
  )

model_summary