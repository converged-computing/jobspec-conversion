#!/bin/bash
#FLUX: --job-name=docker-hello-mpi
#FLUX: --exclusive
#FLUX: --priority=16

sudo service docker start
sudo docker run -i -v `pwd`:`pwd` -w `pwd` avidalto/openmpi-ubuntu:v3 mpirun \
    --allow-run-as-root \
    -np 2 \
    mpi_hello_world > mpirun.out
