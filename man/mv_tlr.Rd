\name{pmvn.tlr, pmvt.tlr}
\alias{pmvn.tlr}
\alias{pmvt.tlr}
\title{Two Tile-low-rank-based functions}
\description{
  Compute multivariate normal and Student-t probabilities with the tile-low-rank method.
}
\usage{
pmvn.tlr(lower=-Inf, upper=Inf, mean=0, sigma=NULL, geom=NULL, 
  type="matern", para=NULL, uselog2=FALSE, m=64, epsl=1e-3, N=499)
pmvt.tlr(lower=-Inf, upper=Inf, nu=NULL, mean=0, sigma=NULL, geom=NULL, 
  type="matern", para=NULL, uselog2=FALSE, m=64, epsl=1e-3, N=499)
}
\arguments{
  \item{lower}{lower integration limits, a numeric vector of length 1 or the problem size}
  \item{upper}{upper integration limits, a numeric vector of length 1 or the problem size}
  \item{nu}{degrees of freedom, need to be positive}
  \item{mean}{the mean parameter, a numeric vector of length 1 or the problem size}
  \item{sigma}{the covariance matrix, a square matrix that matches the length of `lower`. 
    It cannot be NULL when `geom` is NULL}
  \item{geom}{2D geometry, a matrix whose row number matches the length of a and 
    column number is 2. Each row represents the location of a variable. For the tile-
    low-rank methods, the geometry should be scaled into the unit square, (0,1) X (0,1).
    It cannot be NULL when `sigma` is NULL}
  \item{type}{the name of the covariance kernel, a string. Currently, only the Matern 
    covariance function is supported. Not case-sensitive. It cannot be NULL 
    when `sigma` is NULL}
  \item{para}{the parameter for the covariance kernel, a numeric vector. When `type` 
    is "matern", the length of `para` should be 4, representing the scale, range, 
    smoothness, and nugget parameters of the covariance function. It cannot be NULL 
    when `sigma` is NULL}
  \item{uselog2}{a boolean variable, indicating if the log2 result should be returned.
    This is useful when the true probability is too small for the machine precision.
    When it is set TRUE, the error estimation becomes not available}
  \item{m}{the tile size in the tile-low-rank representation, an integer. A suggested 
    magnitude is the square root of the problem size. A minimum threshold for `m` is 16 
    for the low-rank method to be meaningful. The default tile size is 64}
  \item{epsl}{the tolerance for the relative error, a positive numeric scalar. A smaller 
    tolerance could help in the case of a Cholesky failure but at the cost of increased 
    computational time. The value defaults to 1e-3}
  \item{N}{an integer, specifying the number of per-batch Monte Carlo samples. The 
    total number of Monte Carlo samples is 20 X N}
}
\value{
  When `uselog2` is set FALSE, the two functions return a list of 5 members, namely \enumerate{
  \item the estimated probability
  \item the error estimation 
  \item the time for the block reordering preconditioner 
  \item the time used for Monte Carlo simulation 
  \item the average rank for the off-diagonal low-rank tiles
  }
  The last three values are only for users familiar with the matter.
  
  When `uselog2` is set TRUE, the error estimation is not returned.
}
\details{
  Internally, both `pmvn.tlr` and `pmvt.tlr` have two routines. When `sigma`, 
  the covariance matrix, is given, `geom`, `type`, and `para` are not used. 
  However, in this case, the off-diagonal tiles of `sigma` should be approximately
  low rank. Otherwise, using the tile-low-rank approximation may cause estimation
  bias. When `sigma` is not given, a tile-low-rank covariance matrix is created 
  with the information from `geom`, `type`, and `para`. This is more memory 
  friendly but supports only 2D spatial covariance matrices with a Matern kernel
}
\references{
  Cao, J., Genton, M. G., Keyes, D. E., & Turkiyyah, G. M. (2019). "Exploiting Low
Rank Covariance Structures for Computing High-Dimensional Normal and Student-
t Probabilities"
}
\examples{
  n = 260
  set.seed(0)
  a = rep(-10, n)
  b = rnorm(n, 5, 2)
  m = 16
  gridDim = 20
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
  pmvn.tlr(a, b, 0, covM, NULL, NULL, NULL, FALSE, m, epsl)
  pmvn.tlr(a, b, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE, m, epsl)
  
  nu = 10
  pmvt.tlr(a, b, nu, 0, covM, NULL, NULL, NULL, TRUE, m, epsl)
  pmvt.tlr(a, b, nu, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), TRUE, m, epsl)
}
\author{Jian Cao, Marc Genton, David Keyes, George Turkiyyah}

