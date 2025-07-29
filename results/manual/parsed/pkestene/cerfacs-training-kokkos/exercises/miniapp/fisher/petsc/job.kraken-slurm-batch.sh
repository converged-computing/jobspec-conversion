#!/bin/bash
#SBATCH --job-name=petsc-miniapp-test
#SBATCH --output=job%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a30:4
#SBATCH --time=00:10:00

mpirun ./main -ts_monitor -snes_monitor -ksp_monitor
