#!/bin/bash
#SBATCH --job-name=lap_opm
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --time=01:30:00

    lscpu
    echo "    "
    echo "*** SEQUENTIAL ***"
    srun singularity run container.sif laplace_seq 2048
    for j in {1,2,5,10,20,40,64};
        do
            export OMP_NUM_THREADS=$j
            echo "*** OPENMP COM $j THREADS ***"
            srun singularity run container.sif laplace_omp 2048
            echo "    "
            echo "*** OPENMP COLLAPSE COM $j THREADS ***"
            srun singularity run container.sif laplace_omp_collapse 2048
            echo "    "
        done
    echo "    "
