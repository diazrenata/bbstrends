library(nlme)
library(drake)
library(dplyr)
library(ggplot2)
loadd(all_sv_scaled)

all_sv_scaled <- all_sv_scaled %>%
  mutate(dataset = paste0(route, "_", region))


inds_scaled <- filter(all_sv_scaled, currency == "individuals")

inds_scaled_gls <- gls(response ~ time + dataset, data = inds_scaled) #, correlation = corAR1())

summary(inds_scaled_gls)

ggplot(inds_scaled, aes(x = time, y = response, color = dataset)) +
  geom_line(alpha = .1) +
  geom_abline(slope = inds_scaled_gls$coefficients[2], intercept = mean(inds_scaled_gls$coefficients[-2])) +
  theme_bw() +
  theme(legend.position = "none")


loadd(all_sv)
all_sv <- all_sv %>%
  mutate(dataset = paste0(route, "_", region))


inds <- filter(all_sv, currency == "individuals")

inds_gls <- gls(response ~ time + dataset, data = inds) #, correlation = corAR1())

summary(inds_gls)

ggplot(inds, aes(x = time, y = response, color = dataset)) +
  geom_line(alpha = .1) +
  geom_abline(slope = inds_gls$coefficients[2], intercept = mean(inds_gls$coefficients[-2])) +
  theme_bw() +
  theme(legend.position = "none")


inds <- inds %>%
  mutate(response = scale(response))

inds_gls <- gls(response ~ time + dataset, data = inds, correlation = corAR1())

summary(inds_gls)

ggplot(inds, aes(x = time, y = response, color = dataset)) +
  geom_line(alpha = .1) +
  geom_abline(slope = inds_gls$coefficients[2], intercept = mean(inds_gls$coefficients[-2])) +
  theme_bw() +
  theme(legend.position = "none")
