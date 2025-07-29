#!/bin/bash
#SBATCH --job-name=7DODS0
#SBATCH --output=pairENG.out
#SBATCH --error=pairENG.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=7-00:00:00
#SBATCH --exclude=c[4032-4036]

module load openmpi/4.0.5-skylake-gcc10.1
module load gcc/10.1.0
module load namd/2.14-mpi
source /work/hung_group/xu.jiam/miniconda3/bin/activate
python pair_cal.py
