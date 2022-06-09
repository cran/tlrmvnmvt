#ifndef  USE_FC_LEN_T
# define USE_FC_LEN_T
#endif
#include <Rconfig.h>
#include <R_ext/BLAS.h>
#include <R_ext/Lapack.h>
#ifndef FCONE
# define FCONE
#endif
#include <RcppEigen.h>

using namespace std;
using namespace Eigen;

int inverse(MatrixXd& A)
{
        int n = A.rows();
        int success_code;
        F77_CALL(dtrtri)("L", "N", &n, A.data(), &n, &success_code FCONE FCONE);
        return success_code;
}

