#!/bin/bash
#SBATCH --job-name=indexgen
#SBATCH --account=mh0033
#SBATCH --output=indexgen.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=0G
#SBATCH --time=08:00:00
#SBATCH --partition=compute

cd /work/mh0033/m300883/Tel_MMLE/script/8season
source ~/.bashrc
source activate TelSeason
LD_LIBRARY_PATH=/home/m/m300883/libraries
module load openmpi/4.1.2-intel-2021.5.0
srun -n 30 --mpi=pmi2 env MPICC=/sw/spack-levante/openmpi-4.1.2-yfwe6t/bin/mpicc python -m mpi4py hello1index_generator_500hpa.py
