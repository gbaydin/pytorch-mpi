# pytorch-mpi
A Docker image with OpenMPI and PyTorch to test distributed training codes.

If running MPI within Docker, one might need to allow ptrace permissions by using
```
docker run --cap-add=SYS_PTRACE
```
See: https://github.com/open-mpi/ompi/issues/4948
