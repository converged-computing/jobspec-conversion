#!/bin/bash
#SBATCH --job-name=SIMPA
#SBATCH --account=<ACCOUNT>
#SBATCH --output=./%A.out
#SBATCH --error=./%A.err
#SBATCH --nodes=4
#SBATCH --ntasks=160
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1GB
#SBATCH --time=01:30:00

module load mpi/OpenMPI/3.1.4-GCC-8.3.0
srun --unbuffered -n 160 --mpi=pmi2 python SIMPA.py --bed ./scExamples/H3K4me3_hg38_5kb/BC8791969.bed --targets H3K4me3
