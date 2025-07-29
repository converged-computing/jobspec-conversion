#!/bin/bash
#SBATCH --job-name=pi_acc
#SBATCH --account=project_46
#SBATCH --output=test.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=00:10:00
#SBATCH --partition=standard-g
#SBATCH: --exclusive

export ALLINEA_STOP_AT_MAIN='1'

export ALLINEA_STOP_AT_MAIN=1
module load LUMI/22.12
module load partition/G
module load Linaro_Forge/23.0
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
ddt --connect srun -n 4 pi_openacc
