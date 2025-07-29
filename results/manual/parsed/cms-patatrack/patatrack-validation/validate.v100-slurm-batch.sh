#!/bin/bash
#SBATCH --output=validation.%j.out
#SBATCH --error=validation.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:2
#SBATCH --partition=gpu
#SBATCH --constraint=v100

module purge
module load gcc/8.3.0
module load cuda/10.1.105_418.39
echo Host: `hostname`
echo Available CPU cores:
taskset -c -p $$ | cut -d' ' -f3- | sed -e's/c/C/' -e's/^/  /'
echo Avaliable GPUs:
nvidia-smi -L | sed -e's/^/  /'
./validate "$@"
