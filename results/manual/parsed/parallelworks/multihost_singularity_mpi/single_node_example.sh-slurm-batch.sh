#!/bin/bash
#SBATCH --job-name=docker-hello-mpi
#SBATCH --output=docker-hello-mpi.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --chdir=/home/Matthew.Shaxted/multihost_docker_mpi

sudo service docker start
sudo docker run -i -v `pwd`:`pwd` -w `pwd` avidalto/openmpi-ubuntu:v3 mpirun \
    --allow-run-as-root \
    -np 2 \
    mpi_hello_world > mpirun.out
