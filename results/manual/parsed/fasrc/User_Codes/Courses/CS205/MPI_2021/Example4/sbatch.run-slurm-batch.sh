#!/bin/bash
#SBATCH --job-name=mmult
#SBATCH --output=mmult.out
#SBATCH --error=mmult.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:00:30
#SBATCH --partition=test

PRO=mmult
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
