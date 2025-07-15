#!/bin/bash
#FLUX: --job-name=mpi_grayscale
#FLUX: --queue=compute
#FLUX: --urgency=16

module load cpu/0.15.4 gcc/10.2.0 openmpi/4.0.4
srun -n 1 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 2 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 5 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 10 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
srun -n 20 ./mpi_grayscale cat.jpg comp.jpg gray.jpg 
