## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(asymptor)

## -----------------------------------------------------------------------------
df <- readRDS(system.file("extdata", "covid19_italy.rds", package = "asymptor"))
head(df)

## -----------------------------------------------------------------------------
asy <- estimate_asympto(df$date, df$new_cases, df$new_deaths)

## -----------------------------------------------------------------------------
df <- merge(df, asy)

## ---- example_fig, fig.height = 4.5, fig.width = 9, out.width='100%'----------
library(ggplot2)
ggplot(df, aes(x = date)) +
  geom_line(aes(y = new_cases+lower), col = "grey30") +
  geom_ribbon(aes(ymin = new_cases+lower, 
                  ymax = new_cases+upper), 
              fill = "grey30") +
  geom_line(aes(y = new_cases), color = "red") +
  labs(title = "Estimated total vs detected cases of COVID-19 in Italy",
       y = "Cases") +
  theme_minimal()

