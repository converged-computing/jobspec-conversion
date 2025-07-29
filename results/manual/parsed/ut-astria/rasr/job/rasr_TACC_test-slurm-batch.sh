#!/bin/bash
#SBATCH --job-name=rasr_TACC_test
#SBATCH --account=MSS21024
#SBATCH --output=rasr_TACC_test.o%j
#SBATCH --error=rasr_TACC_test.e%j
#SBATCH --mail-user=carson.l@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:30:00

bash /work/07965/clans/ls6/Spring_RASR/run/rasr_activator_test         # Do not use ibrun or any other MPI launcher
