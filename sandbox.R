library(tidyverse)
library(truncnorm)
library(evir)
library(ercv)
library(POT)

threshold <- 2.90
normal_dist <- rtruncnorm(90000, b = threshold, mean = 2, sd = 0.7 )
normal_label <- rep("norm", length(normal_dist))
gpd_dist <- evir::rgpd(10000, xi = 0.2, mu = threshold, beta = 0.4)
gpd_label <- rep("gpd", length(gpd_dist))

tot <- data.frame(value = c(normal_dist, gpd_dist), dist = c(normal_label, gpd_label))
isa_thrselect <- thrselect(tot$value, nsim = 100)



ggplot(data = tot, aes(x = value, fill = dist))+
  geom_histogram(binwidth = 0.02)+
  xlim(-1,6)+
  geom_vline(xintercept=threshold)


ggplot(data = data.frame(isa_thrselect), aes(x = value))+
  geom_histogram(binwidth = 0.01)+
  geom_vline(xintercept=threshold)



          