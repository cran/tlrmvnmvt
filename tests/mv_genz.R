library(tlrmvnmvt)
library(mvtnorm)
n = 49
a = rep(-10, n)
b = rnorm(n, 5, 2)
m = sqrt(n)
vec1 = 1 : m
vec2 = rep(1, m)
geom = cbind(kronecker(vec1, vec2), kronecker(vec2, vec1))
geom = geom / m
beta = 0.3
distM = as.matrix(dist(geom))
covM = exp(-distM / beta)
val1 = pmvnorm(a, b, sigma = covM)[[1]]
val2 = pmvn.genz(a, b, 0, covM, NULL, NULL, NULL, FALSE)[[1]]
val3 = pmvn.genz(a, b, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE)[[1]]
show("Relative difference with function `pmvnorm`")
show(abs(val2 - val1) / val1)
show(abs(val3 - val1) / val1)

nu = 10
val1 = pmvt(a, b, df = nu, sigma = covM)[[1]]
val2 = pmvt.genz(a, b, nu, 0, covM, NULL, NULL, NULL, FALSE)[[1]]
val3 = pmvt.genz(a, b, nu, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE)[[1]]
show("Relative difference with function `pmvt`")
show(abs(val2 - val1) / val1)
show(abs(val3 - val1) / val1)