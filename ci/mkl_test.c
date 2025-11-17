#include <stdio.h>
#include <mkl.h>

int main() {
    double a[6] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
    double b[6] = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    double c[4];
    
    // C = A * B where A is 2x3, B is 3x2, C is 2x2
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
               2, 2, 3, 1.0, a, 3, b, 2, 0.0, c, 2);
    
    printf("MKL BLAS test call successful\n");
    
    return 0;
}
