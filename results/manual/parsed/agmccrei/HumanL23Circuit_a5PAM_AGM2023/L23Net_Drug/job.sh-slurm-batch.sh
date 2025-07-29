#!/bin/bash
#SBATCH --job-name=LFPy Circuit
#SBATCH --account=rrg-etayhay
#SBATCH --output=output.out
#SBATCH --error=error.out
#SBATCH --mail-user=agmccrei@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:25:00
#SBATCH --constraint=ntasks-per-node=40

module load NiaEnv/2018a
module load intel/2018.2
module load intelmpi/2018.2
module load anaconda3/2018.12
conda activate lfpy
unset DISPLAY
mpiexec -n 400 python circuit.py 1234
