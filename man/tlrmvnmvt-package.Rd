\name{tlrmvnmvt-package}
\alias{tlrmvnmvt}
\docType{package}
\title{
\packageTitle{tlrmvnmvt}
}
\description{
\packageDescription{tlrmvnmvt}
}
\details{
  Implementation of the classic Genz algorithm and a novel tile-low-rank algorithm for computing relatively high-dimensional multivariate normal and Student-t probabilities. For the Genz's algorithm (\code{pmvn.genz}, \code{pmvt.genz}), we apply a univariate reordering preconditioner and for the tile-low-rank algorithms (\code{pmvn.tlr}, \code{pmvt.tlr}), we apply a recursive block reordering preconditioner. The \code{pmvn.genz} and \code{pmvt.genz} methods are different from the \code{pmvnorm} and \code{pmvt} in the `mvtnorm` package in that the `tlrmvnmvt` package can accept any problem dimension, specify the Monte Carlo sample size, and return the result in the log2 fashion, which is useful when the true probability is smaller than the machine precision. The \code{pmvn.tlr} and \code{pmvt.tlr} functions can compute the probabilities up to tens of thousands of dimensions with the low-rank representation. However, the two functions require the existence of the low-rank property in the off-diagonal tiles. When this property is not strong enough, the tile-low-rank methods may cause estimation bias. Furthermore, if the covariance matrix is close to singular, a weak low-rank property may cause the Cholesky failure in which case, reducing the `epsl` value may or may not help. In general, it is recommended to input `geom` instead of `sigma` or reorder `geom` with the output from `zorder` to generate a stronger low-rank feature.
  
  Package functions: pmvn.genz, pmvt.genz, pmvn.tlr, pmvt.tlr, zorder
}
\author{
\packageAuthor{tlrmvnmvt}

Maintainer: \packageMaintainer{tlrmvnmvt}
}
\references{
Cao, J., Genton, M. G., Keyes, D. E., & Turkiyyah, G. M. (2019). "Exploiting Low
Rank Covariance Structures for Computing High-Dimensional Normal and Student-
t Probabilities"
}
