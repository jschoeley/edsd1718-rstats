#' ---
#' title: "Matrix algebra"
#' author: "Jonas Schöley"
#' date: "September 22th, 2017"
#' output:
#'   github_document:
#'     toc: true
#'   pdf_document:
#'     toc: true
#' ---

#'## Basic matrix function and operations

#' Creating a matrix:
matrix(1:9, nrow = 3)
cbind(1:3, 4:6, 7:9)
matrix(1:9, nrow = 3, byrow = TRUE)
rbind(1:3, 4:6, 7:9)
diag(3)

#' Element-by-element arithmetic of a matrix with a scalar:
M <- matrix(1, nrow = 3, ncol = 3)
M
M*3
M+3

#' Element-by-element arithmetic of a matrix with a vector:
M*1:3
#M*1:2 # carefull

#' Transposing a vector:
v <- 1:9 # a column vector
v
t(v) # a row vector (a matrix with a single row)

#' Transposing a matrix:
M2 <- matrix(1:9, nrow = 3)
M2
t(M2)

#' Matrix multiplication of a matrix with a vector:
M %*% 1:3
#M %*% t(1:3) # carefull (n*m <> m*k)

#' Matrix multiplication of a matrix with a matrix:
set.seed('1987') # for reproducibility
M3 <- matrix(sample(0:3, size = 9, replace = TRUE), nrow = 3)
M4 <- matrix(sample(0:1, size = 9, replace = TRUE), nrow = 3)
M3 %*% M4
M4 %*% M3
M4 %*% diag(3)

#' Matrix inverse
solve(M3)
solve(M3)%*%M3

#' Solving a system of linear equations:
B <-
  rbind(
    c(25, 3, 9),
    c(9, 10, 5),
    c(14, 35, 4)
  )
Y <- c(13, 11, 11)
X <- solve(B, Y)
B%*%X

#'## Population projections using the Leslie-Matrix

# the Leslie matrix (population projection matrix)
A <- rbind(
  c(0, 1, 5),
  c(0.3, 0, 0),
  c(0, 0.5, 0)
)

# the initial population distribution
N0 <- c(100, 0, 0)

# population after single time step
N1 <- A%*%N0; N1
# population after 2 time steps
N2 <- A%*%N1; N2
# population after 3 time steps
N3 <- A%*%N2; N3

# a package for matrix exponentiation
# install.packages('expm')
library(expm)
A%^%3 %*% N0 # same as N3

# population structure in the distant future
A%^%100 %*% N0

# projecting total population size 100 time
# steps into the future
Nt <- rep(NA, times = 100)
for (t in 1:100) {
  Nt[t] <- sum(A%^%t %*% N0)
}
plot(Nt, type = 'l')
plot(Nt, type = 'l', log = 'y')

# intrinsic growth rate
r <- Re(eigen(A)$values[1])
r
log(r)

# log(Nt) ~ a + bt
# Nt ~ exp(a + bt)
# Nt ~ exp(a) * exp(bt)
time <- 1:100
lm(log(Nt)~time)

#'## Projecting an animal population

load('COMADRE_v.2.0.1.RData')

# population matrix for Australian females 1980-1985
A_aus <- comadre$mat[[777]][['matA']]

# class (age) labels for matrix 777
age_lab <- comadre$matrixClass[[777]][[2]]

# stable population distribution
p_stable_aus <- prop.table(Re(eigen(A_aus)$vectors[,1]))
# intrinsic growth rate
r_aus <- Re(eigen(A_aus)$values[1])
r_aus

data.frame(x = age_lab, p = p_stable_aus)
