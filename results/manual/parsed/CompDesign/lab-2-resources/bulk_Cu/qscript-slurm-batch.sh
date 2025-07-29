#!/bin/bash
#SBATCH --job-name=lammps
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1

export OMP_NUM_THREADS='1'

INPUT_FILE='fix_fcc_Cu.in'
export OMP_NUM_THREADS=1
echo "--- STARTING JOB SCRIPT -----------------------------------------"
echo "-> Loading Modules"
module load intel_parallel_studio_xe/2020.1
echo "-> Working directory"
pwd
echo "--- RUNNING PI     ----------------------------------------------"
mpirun -n 12 $HOME/bin/lmp < $INPUT_FILE
echo "--- FINISHING JOB SCRIPT ----------------------------------------"
