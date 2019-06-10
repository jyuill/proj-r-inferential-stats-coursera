## Monte Carlo Simulation Example

## create simulations for website conversions

## general model
## sessions x conversion rate x average spend = revenue

library(tidyverse)
library(gridExtra)
sess <- rnorm(100, mean=100, sd=12)
sess
hist(sess)

cr <- rnorm(100, mean=0.1, sd=0.02)
cr
hist(cr)

avesp <- rnorm(100, mean=2.50, sd=0.55)
avesp
hist(avesp)

rev <- sess * cr * avesp
rev
hist(rev)
mean(rev)
sd(rev)

### generating skewed distribution
## basic example log normal distribution
ldist <- rlnorm(100, meanlog=0, sdlog=1)
hist(ldist)

## avesp
avesp.lg <- rlnorm(100, meanlog=2.50, sdlog=0.55)
par(mfrow=c(1,2))
hist(avesp.lg)
hist(avesp)
df.avesp <- data.frame(avesp.lg=avesp.lg,
                       avesp=avesp)
p.avesp <- ggplot(df.avesp, aes(x=avesp))+geom_histogram()+
  geom_vline(xintercept = mean(avesp))
p.avesp.lg <- ggplot(df.avesp, aes(x=avesp.lg))+geom_histogram()+
  geom_vline(xintercept=mean(avesp.lg))

grid.arrange(p.avesp, p.avesp.lg, nrow=2)