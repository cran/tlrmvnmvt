# tlrmvnmvt 1.0.0

The initial release of the package.

For a complete description of the package functions, please refer to the help file. To install a highly optimized version of this package, please refer to the README.md file. 

# tlrmvnmvt 1.0.1

This version fixed four bugs:
	1. The memory allocation size error in functions `mvn_internal`, `mvn_internal2`, `mvt_internal`, and `mvt_internal2`
	2. Change the position of the memory release command
	3. Correct the functioning of the mean parameter. It was assumed to be "shifted" but should be "Kshirsagar"; Refer to `mvtnorm::pmvt` function's documentation for the meaning of the two names
	4. Implement the internal Matern function so that it produces the same result as the `geoR::matern` function
