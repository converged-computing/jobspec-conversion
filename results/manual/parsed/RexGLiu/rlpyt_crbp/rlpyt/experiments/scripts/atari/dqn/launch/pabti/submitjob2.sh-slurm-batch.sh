#!/bin/bash
#SBATCH --job-name=gravitar2
#SBATCH --account=carney-tserre-condo
#SBATCH --output=gravitar2.out
#SBATCH --error=gravitar_err2.out
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=100G
#SBATCH --time=8-04:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=quadrortx

module load anaconda/3-5.2.0
module load cuda/10.1.105
module load gcc/5.4
module load ninja/1.9.0
source activate torch
python launch_atari_r2d1_async_alt_gravitar_v2.py > gravitar_out2.txt
