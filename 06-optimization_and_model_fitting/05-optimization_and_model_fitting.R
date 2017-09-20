# Optimization basics -----------------------------------------------------

# Optimizing a function means finding
# the parameters where said function reaches
# its minimum value. As a trivial first
# demonstration we optimize the quadradic function.
Quadratic <- function (x) { x^2 }
curve(Quadratic, from = -1, to = 1)

# Search the function "Quadratic" from for a
# minimum value over the interval x = -10 to 10.
op_q <- optimize(Quadratic, interval = c(-10, 10))
op_q
# The value of x where y=x^2 is smallest.
op_q$minimum

# If our function is more complex and depends on
# multiple parameters we need to use the "optim" function.
QuadraticSurf <- function (x, y) {x^2 + y^2}
x <- y <- -10:10; z <- outer(x, y, QuadraticSurf)
persp(x = x, y = y, z = z)

# Find the values for parameters x and y where
# the value of the function "QuadraticSurf" is
# smallest. Start the search at x and y values of -10.
op_qs <-
  optim(par = c(x = -10, y = -10),
        fn = function (pars) { QuadraticSurf(x = pars[1], y = pars[2]) })
# The optimized parameter values:
op_qs$par
# The value of "QuadraticSurf" at the optimized
# parameter values:
op_qs$value

# We see that the solution returned by optim is not exact.
# The lowest point of the function y = x^2+y^2 is at x = 0 and y = 0.
# This imprecision is a fact of life with numerical optimization.
# The impricision gets smaller the closer the starting values
# are to the solution.
optim(par = c(x = -0.1, y = -0.1),
      fn = function (pars) { QuadraticSurf(x = pars[1], y = pars[2]) })

# When using `optim` we usually write an objective
# function. This function has as first argument
# a vector of parameters to be fitted.

# The "objective function" is the function we
# wish to minimize.
ObjectiveFunQS <- function (pars) {
  QuadraticSurf(x = pars[1], y = pars[2])
}

# Same result as before, just written differently.
op_qs2 <-
  optim(par = c(x = -10, y = -10),
        fn = ObjectiveFunQS)

# Using optim to fit a function to data -----------------------------------

# survival times
survival_times <- read.table("ltGomp.txt")
hist(survival_times$x, freq = FALSE)

# Log-likelihood function of Gompertz distribution
ObjectiveFunLLGomp <- function(pars, x){
  alpha <- pars[1]
  beta <- pars[2]
  loglk <- log(alpha) + beta*x + alpha/beta*(1 - exp(beta*x))
  sumloglk <- -sum(loglk)
  return(sumloglk)
}

# maximize the likelihood function (actually minimize the negative likelihood)
op_go <- optim(par = c(0.001, 0.05), fn = ObjectiveFunLLGomp, x = survival_times)

# Gompertz density function
GompertzFun <- function (x, a, b) {
  a*exp(x*b)*exp(-a/b*(exp(b*x)-1))
}

lines(x = 40:100, GompertzFun(x = 40:100, a = op_go$par[1], b = op_go$par[2]))

# Linear models -----------------------------------------------------------

library(tidyverse)

load("hmd_lt.RData")

# for each life-table, extract total
# life-expectancy and calculate the 
# coefficient of variation of the 
# age distribution of deaths
e0cv <-
  hmd_lt %>%
  group_by(cntry, sex, Year) %>%
  summarise(
    e0 = first(ex),
    cv = (sqrt(sum(dx/1e5*(Age+ax-e0)^2)) / e0)
  ) %>% ungroup()

# plot the data
e0cv %>%
  ggplot() +
  geom_path(aes(x = e0, y = cv, color = sex)) +
  facet_wrap(~cntry, scales = 'free')

# Let's just look at the relationship
# between e0 and cv among Swedish females
e0cv_sub <-
  e0cv %>%
  filter(cntry == 'SWE', sex == 'female')

# fit a linear regression of e0 against cv to the data
model_fit <- glm(formula = cv ~ e0, data = e0cv_sub)
coef(model_fit)
summary(model_fit)
a <- coef(model_fit)[1]
b <- coef(model_fit)[2]
plot(x = e0cv_sub$e0, y = e0cv_sub$cv)
abline(a = a, b = b)

# now for the complete data using co-variables
model_fit <- glm(formula = cv ~ e0 + sex + cntry, data = e0cv)
summary(model_fit)
coef(model_fit)
plot(model_fit)

# Group-wise model fitting ------------------------------------------------

# Fit a separate linear regression model
# to each combination of country and sex
# and return the intercept and the slope.
e0cv %>%
  group_by(cntry, sex) %>%
  do({
    fit <- glm(formula = cv ~ e0, data = .)
    data.frame(
      a = coef(fit)[1],
      b = coef(fit)[2]
    )
  })
