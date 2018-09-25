#include<iostream>
#include"DtSmithWilson.h"

//double _stdcall myadd(double a, double b) {
//	return a + b;
//}



void _stdcall smith_wilson_engine(double* spot_grid, int n_grid, double* t_in, double* cf_in, int nsec_in, int nt_in) {

	for (int i = 0; i < n_grid; i++) {
		spot_grid[i] = cf_in[1];
	}
	


}