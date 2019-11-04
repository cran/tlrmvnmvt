#ifndef MVT_H
#define MVT_H
#include <RcppEigen.h>
int mvt(int N, double nu, const Eigen::MatrixXd& L, const Eigen::VectorXd &a1, 
	const Eigen::VectorXd &b1, double& v, double& e, int ns, int &scaler_in, 
	double *workDbl, int lworkDbl, int *workInt, int lworkInt);
#endif
