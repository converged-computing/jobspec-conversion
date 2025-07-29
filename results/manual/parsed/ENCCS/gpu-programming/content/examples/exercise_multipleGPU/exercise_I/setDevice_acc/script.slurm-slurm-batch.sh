#!/bin/bash
#SBATCH --job-name=setDevice_acc
#SBATCH --account=project_465000485
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --time=00:10:00
#SBATCH --partition=dev-g
#SBATCH --constraint=ntasks-per-node=4

module load CrayEnv
module load PrgEnv-cray
module load cray-mpich
module load craype-accel-amd-gfx90a
module load rocm
srun ./assignDevice.acc.exe | sort
echo 
