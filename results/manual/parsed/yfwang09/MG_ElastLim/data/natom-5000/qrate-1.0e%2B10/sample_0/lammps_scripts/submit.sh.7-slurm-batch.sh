#!/bin/bash
#SBATCH --job-name=step-7
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu-geforce
#SBATCH --nodelist=gpu-200-4

/home/yfwang09/Codes/lammps/src/lmp_icc_serial -sf gpu -pk gpu 1 -in /home/yfwang09/Codes/MLmat/MetallicGlass/data/natom-5000/qrate-1.0e+10/sample_0/lammps_scripts/in.7
wait
