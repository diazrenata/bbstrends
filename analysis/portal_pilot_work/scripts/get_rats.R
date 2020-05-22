library(dplyr)

rats_n = portalr::abundance(time = "date", level = "Treatment")

rats_n <- rats_n %>%
  mutate(year = substr(censusdate, 0, 4)) %>%
  mutate(total_abund = rowSums(.[3:23])) %>%
  select(year, treatment, total_abund) %>%
  group_by(year, treatment) %>%
  summarize(total_abund = sum(total_abund)) %>%
  ungroup()

rats_e = portalr::energy(time = "date", level = "Treatment")

rats_e <- rats_e %>%
  mutate(year = substr(censusdate, 0, 4)) %>%
  mutate(total_energy = rowSums(.[3:23])) %>%
  select(year, treatment, total_energy) %>%
  group_by(year, treatment) %>%
  summarize(total_energy = sum(total_energy)) %>%
  ungroup()

rats_sv = left_join(rats_e, rats_n)

write.csv(rats_sv, here::here("analysis", "portal_pilot_work", "data", "portal_rats_sv.csv"), row.names = F)


rats_pop_n = portalr::abundance(time = "date", level = "Treatment")

rats_pop_n <- rats_pop_n %>%
  mutate(year = substr(censusdate, 0, 4)) %>%
  select(-censusdate) %>%
  group_by(year, treatment) %>%
  summarize_if(is.numeric, sum) %>%
  ungroup() %>%
  tidyr::pivot_longer(cols = BA:SO,
                      names_to = "species",
                      values_to = "abundance")

rats_pop_e = portalr::energy(time = "date", level = "Treatment")

rats_pop_e <- rats_pop_e %>%
  mutate(year = substr(censusdate, 0, 4)) %>%
  select(-censusdate) %>%
  group_by(year, treatment) %>%
  summarize_if(is.numeric, sum) %>%
  ungroup()  %>%
  tidyr::pivot_longer(cols = BA:SO,
                      names_to = "species",
                      values_to = "energy")

rats_pop = left_join(rats_pop_n, rats_pop_e)
write.csv(rats_pop, here::here("analysis", "portal_pilot_work", "data", "portal_rats_pop.csv"), row.names = F)
