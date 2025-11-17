program mkl_test
    implicit none
    double precision :: a(2,3), b(3,2), c(2,2)
    integer :: i, j
    
    ! Initialize matrices
    do i = 1, 2
        do j = 1, 3
            a(i,j) = (i-1)*3 + j
        end do
    end do
    
    b = 1.0d0
    c = 0.0d0
    
    ! C = A * B
    call dgemm('N', 'N', 2, 2, 3, 1.0d0, a, 2, b, 3, 0.0d0, c, 2)
    
    print *, 'MKL BLAS Fortran test successful'
    print *, 'Result:', c
end program mkl_test
