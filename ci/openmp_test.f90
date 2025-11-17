program openmp_test
    use omp_lib
    implicit none
    integer :: tid, nthreads
    
    !$omp parallel private(tid, nthreads)
    tid = omp_get_thread_num()
    nthreads = omp_get_num_threads()
    !$omp critical
    print *, 'Hello from OpenMP thread', tid, 'of', nthreads
    !$omp end critical
    !$omp end parallel
end program openmp_test
