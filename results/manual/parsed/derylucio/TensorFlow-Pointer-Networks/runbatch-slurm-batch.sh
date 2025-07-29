#!/bin/bash
#SBATCH --job-name=jigsaws_pointer
#SBATCH --output=runlogs/jigsaws_pointer.%j.out
#SBATCH --error=runlogs/jigsaws_pointer.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=04:30:00

source  .env/bin/activate
module load python/3.5.0
module load cudnn/5.1
module load cuda80/blas/8.0.44
module load cuda80/toolkit/8.0.44
