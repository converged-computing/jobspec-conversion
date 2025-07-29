#!/bin/bash
#SBATCH --job-name=SWM
#SBATCH --account=NTDD0002
#SBATCH --output=SWM.out
#SBATCH --error=SWM.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=dav
#SBATCH --constraint=ntasks-per-node=18

module purge
module load pgi/20.4
module load cuda
module list
nvidia-smi
pgcc -O2 -acc -ta=tesla:cc70 -Minfo -Mnofma shallow_swap.acc.Tile.c wtime.c -o SWM_gpu
./SWM_gpu > results.gpu.Tile.$(date +%m%d%H%M%S).txt
