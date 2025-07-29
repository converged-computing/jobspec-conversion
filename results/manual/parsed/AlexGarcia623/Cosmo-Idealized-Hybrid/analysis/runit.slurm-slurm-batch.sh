#!/bin/bash
#SBATCH --job-name=mov
#SBATCH --output=plots/logs/output_%j.out
#SBATCH --error=plots/logs/error_%j.err
#SBATCH --mail-user=j.rose@ufl.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5000mb
#SBATCH --time=03:00:00
#SBATCH --partition=hpg2-compute
#SBATCH --qos=paul.torrey

module purge
module load intel/2018.1.163 gsl/2.4 openmpi/3.1.2 python3
module list
mpirun -n 10 python make_movie.py 
