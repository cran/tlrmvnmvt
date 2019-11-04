\name{pmvn.genz, pmvt.genz}
\alias{pmvn.genz}
\alias{pmvt.genz}
\title{Two Dense-matrix-based functions}
\description{
  Compute multivariate normal and Student-t probabilities with the classic Genz method.
}
\usage{
pmvn.genz(lower=-Inf, upper=Inf, mean=0, sigma=NULL, geom=NULL, 
  type="matern", para=NULL, uselog2=FALSE, N=499)
pmvt.genz(lower=-Inf, upper=Inf, nu=NULL, mean=0, sigma=NULL, geom=NULL, 
  type="matern", para=NULL, uselog2=FALSE, N=499)
}
\arguments{
  \item{lower}{lower integration limits, a numeric vector of length 1 or the problem size}
  \item{upper}{upper integration limits, a numeric vector of length 1 or the problem size}
  \item{nu}{degrees of freedom, need to be positive}
  \item{mean}{the mean parameter, a numeric vector of length 1 or the problem size}
  \item{sigma}{the covariance matrix, a square matrix that matches the length of `lower`. 
    It cannot be NULL when `geom` is NULL}
  \item{geom}{2D geometry, a matrix whose row number matches the length of a and 
    column number is 2. Each row represents the location of a variable. It cannot 
    be NULL when `sigma` is NULL}
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
  \item{N}{an integer, specifying the number of per-batch Monte Carlo samples. The 
    total number of Monte Carlo samples is 20 X N}
}
\value{
  When `uselog2` is set FALSE, the two functions return a list of 4 members, namely \enumerate{
  \item the estimated probability
  \item the error estimation 
  \item the time for the univariate reordering preconditioner 
  \item the time used for Monte Carlo simulation 
  }
  The last two values are only for users familiar with the matter.
  
  When `uselog2` is set TRUE, the error estimation is not returned.
}
\details{
  Internally, both `pmvn.genz` and `pmvt.genz` have two routines. When `sigma`, 
  the covariance matrix, is given, `geom`, `type`, and `para` are not used. 
  Otherwise, a covariance matrix is created with the information from `geom`, 
  `type`, and `para`.
}
\references{
  Genz, A. (1992), "Numerical computation of multivariate
normal probabilities," Journal of Computational and
Graphical Statistics, 1, 141-149.
}
\examples{
  n = 49
  set.seed(0)
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
  pmvn.genz(a, b, 0, covM, NULL, NULL, NULL, FALSE)
  pmvn.genz(a, b, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), FALSE)
  
  nu = 10
  pmvt.genz(a, b, nu, 0, covM, NULL, NULL, NULL, TRUE)
  pmvt.genz(a, b, nu, 0, NULL, geom, "matern", c(1.0, 0.3, 0.5, 0.0), TRUE)
}
\author{Jian Cao, Marc Genton, David Keyes, George Turkiyyah}

