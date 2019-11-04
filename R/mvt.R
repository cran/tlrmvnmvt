pmvt.genz <- function(lower=-Inf, upper=Inf, nu=NULL, mean=0, sigma=NULL, 
                     geom=NULL, type="matern", para=NULL, uselog2=FALSE, N=499)
{
  # check geom and sigma
  if(is.null(sigma) && is.null(geom))
    stop("Either `sigma` or `geom` should be given")
  if(!is.null(sigma))
  {
    mtd = 1
    n = nrow(sigma)
    if(ncol(sigma) != n)
      stop("Row number and column number of `Sigma` do not match")
    if(any(is.na(sigma)))
      stop("`sigma` contains NA")
  }else
  {
    mtd = 2
    n = nrow(geom)
    if(ncol(geom) < 1)
      stop("For `mvn.genz`, `geom` should have at least one column")
    if(any(is.na(geom)))
      stop("`geom` contains NA")
  }
  # check lower, upper, and mean
  if(n == 0)
    stop("Problem dimension cannot be zero")
  if(!is.numeric(lower) || !is.vector(lower))
    stop('`lower` should be numeric vector')
  if(!is.numeric(upper) || !is.vector(upper))
    stop('`upper` should be numeric vector')
  if(!is.numeric(mean) || !is.vector(mean))
    stop('`mean` should be numeric vector')
  if(length(lower) == 1)
    lower = rep(lower, n)
  if(length(lower) != n)
    stop('Length of `lower` does not match the problem dimension')
  if(length(upper) == 1)
    upper = rep(upper, n)
  if(length(upper) != n)
    stop('Length of `upper` does not match the problem dimension')
  if(length(mean) == 1)
    mean = rep(mean, n)
  if(length(mean) != n)
    stop('Length of `mean` does not match the problem dimension')
  if(any(is.na(lower)))
    stop("`lower` contains NA")
  if(any(is.na(upper)))
    stop("`upper` contains NA")
  if(any(is.na(mean)))
    stop("`mean` contains NA")
  # check covariance type and parameters
  if(mtd == 2)
  {
    if(tolower(type) == "matern")
    {
      if(!is.numeric(para) || !is.vector(para))
        stop("`para` should be a numeric vector")
      if(length(para) != 4)
        stop("`para` should be of length 4, denoting scale, range, 
             smoothness, and nugget")
      if(any(is.na(para)))
        stop("`para` contains NA")
      if(any(para[1:3] <= 0))
        stop("scale, range, and smoothness parameters should all 
             be positive")
      kernelType = 1
    }
    # else if
    else
    {
      stop("Unsupported covariance `type`")
    }
  }
  # check N
  if(!is.numeric(N))
    stop("`N` should be numeric")
  if(is.na(N))
    stop("`N` cannot be NA")
  if(length(N) != 1)
    stop("`N` should be of length 1")
  if(N < 100)
    stop("Monte Carlo sample size `N` should be at least 100")
  # check nu
  if(!is.numeric(nu))
    stop("`nu` should be numeric")
  if(is.na(nu))
    stop("`nu` cannot be NA")
  if(length(nu) != 1)
    stop("`nu` should be of length 1")
  if(nu <= 0)
    stop("`nu` should be positive")
  # convert uselog2 to logical
  uselog2 = as.logical(uselog2)
  # pass to the internal function
  lower <- lower - mean
  upper <- upper - mean
  if(any(lower > upper))
    stop("At least one `upper` coefficient is smaller than `lower`")
  if(mtd == 1)
  {
    mvt_internal(lower, upper, nu, sigma, uselog2, N)
  }else
  {
    mvt_internal2(lower, upper, nu, geom, kernelType, para[1:3], para[4], uselog2, N)
  }
}