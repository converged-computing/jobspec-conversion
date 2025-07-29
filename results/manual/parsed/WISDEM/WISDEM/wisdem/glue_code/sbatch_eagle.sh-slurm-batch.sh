#!/bin/bash
#SBATCH --job-name=Design1
#SBATCH --account=bar
#SBATCH --output=job1.%j.out
#SBATCH --mail-user=user@nrel.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=36

nDV=11  # Number of design variables (x2 for central difference)
source deactivate
module purge
module load conda
module load mkl/2019.1.144 cmake/3.12.3
module load gcc/8.2.0
conda activate wisdem-env
mpirun -np $nDV python runWISDEM.py
