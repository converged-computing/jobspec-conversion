#!/bin/bash
#SBATCH --job-name=tex
#SBATCH --account=sds154
#SBATCH --output=exp_texture.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=02:00:00
#SBATCH --partition=gpu-shared
#SBATCH --constraint=ntasks-per-node=6

module load matlab
matlab -nodisplay -nosplash -nojvm -r "exp_texture()"
