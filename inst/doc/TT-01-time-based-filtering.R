## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tibbletime)
library(dplyr)
library(tidyr)

## ---- message=FALSE, warning=FALSE---------------------------------------
library(tibbletime)

# Facebook stock prices.
data(FB)

# Convert FB to tbl_time
FB <- as_tbl_time(FB, index = date)

# FANG stock prices
data(FANG)

# Convert FANG to tbl_time and group
FANG <- as_tbl_time(FANG, index = date) %>%
  group_by(symbol)


## ------------------------------------------------------------------------
filter(FB, date >= as.Date("2013-01-01"), date <= as.Date("2013-12-31"))

## ------------------------------------------------------------------------
time_filter(FB, time_formula = 2013-01-01 ~ 2013-12-31)

## ------------------------------------------------------------------------
time_filter(FB, 2013 ~ 2013)

## ------------------------------------------------------------------------
time_filter(FB, ~2013)

## ------------------------------------------------------------------------
time_filter(FB, ~2015-03)

# In dplyr it looks like this
# (and you have to think, does March have 30 or 31 days?)
# filter(FB, date >= as.Date("2015-03-01"), date <= as.Date("2015-03-31"))

## ------------------------------------------------------------------------
FANG %>%
  time_filter(2013-01-01 ~ 2013-01-04)

## ------------------------------------------------------------------------
# Dummy example. Every second in a day
example <- create_series(~2013-01-01, period = 1~s)

# The first 2 minutes of the day
example %>%
  time_filter(2013-01-01 ~ 2013-01-01 + 00:02)

# 3 specific hours of the day
# Equivalent to:
# 2013-01-01 + 03:00:00 ~ 2013-01-01 + 06:59:59
example %>%
  time_filter(2013-01-01 + 3 ~ 2013-01-01 + 6)

## ------------------------------------------------------------------------
FB[~2013]

## ------------------------------------------------------------------------
FB[2013~2014-02, c(1,2,3)]

