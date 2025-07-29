#!/bin/bash
#SBATCH --job-name=test_folive00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --no-requeue

export code='/u/dssc/folive00/Foundations_of_HPC_2022/Assignment/exercise1'
export OMP_NUM_THREADS='8'
export OMP_PLACES='cores'
export OMP_PROC_BIND='close'

module load architecture/AMD
module load openMPI/4.1.4/gnu/12.2.1
export code=/u/dssc/folive00/Foundations_of_HPC_2022/Assignment/exercise1
export OMP_NUM_THREADS=8
export OMP_PLACES=cores
export OMP_PROC_BIND=close
cd $code
mpicc -fopenmp main/main.c main/game_functions.c main/write_pgm_images.c
cd correctness
mpirun -np 1 --map-by socket ../a.out -r -x 30 -y 40 -e 1 -n 10 -s 1 -f correct_30x40.pgm
./visualize.x -x 30 -y 40 -f correct_30x40.pgm >> visualizing_correct_30x40.txt
