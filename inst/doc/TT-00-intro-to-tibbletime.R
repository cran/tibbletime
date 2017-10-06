## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tibbletime)
library(dplyr)
library(tidyr)

## ---- message=FALSE, warning=FALSE---------------------------------------
library(tibbletime)

# Facebook stock prices. Comes with the package
data(FB)

# Convert FB to tbl_time
FB <- as_tbl_time(FB, index = date)

FB

## ------------------------------------------------------------------------
# Filter for dates from March 2013 to December 2015
FB %>% 
  time_filter(2013-03 ~ 2015)

# Change from daily to monthly periodicity
FB %>% 
  as_period("monthly")

# Get the average mean and standard deviation for each year
FB %>%
  time_summarise(period = 1~y,
        adj_mean = mean(adjusted),
        adj_sd   = sd(adjusted))

# Perform a 5 period rolling average
mean_5 <- rollify(mean, window = 5)
FB %>%
  mutate(roll_mean = mean_5(adjusted))

# Create a time series
# Every other day in 2013
create_series(~2013, 2~d)

## ------------------------------------------------------------------------
# Facebook, Amazon, Netflix and Google stocks
data(FANG)

# Summarise by period and by group
FANG %>% 
  as_tbl_time(date) %>%
  group_by(symbol) %>%
  time_summarise(period = "yearly",
        adj_min   = min(adjusted),
        adj_max   = max(adjusted),
        adj_range = adj_max - adj_min)

