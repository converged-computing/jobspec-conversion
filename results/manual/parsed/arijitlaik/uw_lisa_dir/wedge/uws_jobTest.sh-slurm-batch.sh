#!/bin/bash
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=avx2

echo "********** CPU-INFO**********"
lscpu
echo "********** Run Started **********"
srun -n 48 singularity exec --pwd $PWD uwgeodynamics-dev.simg  python3 Tutorial_10_Thrust_Wedges.py
wait
