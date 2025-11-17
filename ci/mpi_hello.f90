program mpi_hello
    use mpi
    implicit none
    integer :: ierr, rank, size
    
    call MPI_INIT(ierr)
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierr)
    
    print *, 'Hello from MPI rank', rank, 'of', size
    
    call MPI_FINALIZE(ierr)
end program mpi_hello
