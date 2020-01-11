library(tlrmvnmvt)
library(mvtnorm)
set.seed(123)
n = 260
a = rep(-10, n)
b = rnorm(n, 5, 2)
m = 16
gridDim = 60
epsl = 1e-3
vec1 = 1:gridDim
vec2 = rep(1, gridDim)
geom = cbind(kronecker(vec1, vec2), kronecker(vec2, vec1))
geom = geom / gridDim
geom = geom[sample(c(1:(gridDim^2)), n, FALSE), 1:2]
beta = 0.3
idx = zorder(geom)
geom = geom[idx, 1:2]
a = a[idx]
b = b[idx]
distM = as.matrix(dist(geom))
covM = exp(-distM / beta)
val1 = pmvnorm(a, b, sigma = covM)[[1]]
val2 = pmvn.tlr(a, b, 0, covM, NULL, NULL, NULL, FALSE, m, epsl)[[1]]
val3 = pmvn.tlr(a, b, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE, m, epsl)[[1]]
show("Relative difference with function `pmvnorm`")
show(abs(val2 - val1) / val1)
show(abs(val3 - val1) / val1)

nu = 10
val1 = pmvt(a, b, df = nu, sigma = covM)[[1]]
val2 = pmvt.tlr(a, b, nu, 0, covM, NULL, NULL, NULL, FALSE, m, epsl)[[1]]
val3 = pmvt.tlr(a, b, nu, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE, m, epsl)[[1]]
show("Relative difference with function `pmvt`")
show(abs(val2 - val1) / val1)
show(abs(val3 - val1) / val1)
