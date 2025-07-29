#!/bin/bash
#SBATCH --job-name=exp3
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=150G
#SBATCH --time=00:05:00

singularity exec \
        --nv -w \
        ../../transfer sh -c "cd .. &&  sh experiments/mot17_half_ft_ch_jla_10_60_128.sh"
