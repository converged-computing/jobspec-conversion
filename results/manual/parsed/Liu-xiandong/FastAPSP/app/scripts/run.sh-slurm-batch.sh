#!/bin/bash
#SBATCH --output=out_test_20210514
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=dcu:4
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --no-requeue

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
srun  --cpu_bind=cores  --mpi=pmix  ../builds/singleNodeImproved_path -f delaunay_n16 -k 8 -direct false -weight false
