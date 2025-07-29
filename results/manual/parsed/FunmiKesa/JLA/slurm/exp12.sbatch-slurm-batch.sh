#!/bin/bash
#SBATCH --job-name=exp12
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=150G
#SBATCH --time=00:05:00
#SBATCH --partition=pearl

singularity exec \
        --nv -w \
        ../../transfer sh -c "cd .. &&  sh experiments/mot17_half_jla_15_60.sh"
