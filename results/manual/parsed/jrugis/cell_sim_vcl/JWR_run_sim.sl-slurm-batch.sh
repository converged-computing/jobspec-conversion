#!/bin/bash
#SBATCH --job-name=cell_sim_vcl
#SBATCH --account=nesi00119
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:15:00
#SBATCH --constraint=avx

echo $HOSTNAME
module load intel/2015a
module load Python/3.5.0-intel-2015a
srun -o sim.log ./src/cell_3d
python scripts/compare_bin.py c.bin c_REF.bin 1e-5
