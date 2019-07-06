## Monte Carlo Simulation Example

## create simulations for website conversions

## general model
## sessions x conversion rate x average spend = revenue

library(tidyverse)
library(gridExtra)

par(mfrow=c(2,2)) ## setup for rows, columns of charts

## generate sample of session data, based on normal distribution
sess <- rnorm(100, mean=100, sd=12)
sess
hist(sess)

## generate sample of conversion rate data, based on normal distribution 
cr <- rnorm(100, mean=0.1, sd=0.02)
cr
hist(cr)
## generate sample of ave. spend data, based on normal distribution
avesp <- rnorm(100, mean=2.50, sd=0.55)
avesp
hist(avesp)

## generate sample of rev, based on calculations from the sample data for sess, cr, avesp
## rev data has normal distribution because based on data with normal distributions
## only problem is not realistic: at least some of the data will have a skew
rev <- sess * cr * avesp
rev
hist(rev)
mean(rev)
sd(rev)

### generating skewed distribution
par(mfrow=c(1,1)) ## reset chart layout
## basic example log normal distribution
ldist <- rlnorm(100, meanlog=0, sdlog=1)
hist(ldist)

## avesp
par(mfrow=c(2,1)) ## may need to expand Plots pane
## skewed distrib for ave spend
avesp.lg <- rlnorm(100, meanlog=2.50, sdlog=0.55)
hist(avesp.lg) 
hist(avesp) ## compare to ave spend distribution from above (normal)

## same as above using ggplot2
df.avesp <- data.frame(avesp.lg=avesp.lg,
                       avesp=avesp)
p.avesp <- ggplot(df.avesp, aes(x=avesp))+geom_histogram()+
  geom_vline(xintercept = mean(avesp))
p.avesp.lg <- ggplot(df.avesp, aes(x=avesp.lg))+geom_histogram()+
  geom_vline(xintercept=mean(avesp.lg))
## use grid arrange to display charts together
grid.arrange(p.avesp, p.avesp.lg, nrow=2)

## looking at different distributions: Poisson
lam <- 3000
pois1 <- rpois(n=100, lambda = lam)
par(mfrow=c(1,2))
plot(pois1)
hist(pois1)

## can be unpredictable: not very skewed and at higher lambdas looks pretty normal

## QUESTIONS:
## 1. how to transform log dist into original units?

df.avesp <- df.avesp %>% mutate(
  avesp.trans = e^avesp.lg
)