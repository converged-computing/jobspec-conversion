#!/bin/bash
#SBATCH --job-name=WaveNet
#SBATCH --output=out/%j.out
#SBATCH --error=out/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=15:00:00

module purge
module load openmpi/intel/2.0.3
module load cuda/10.1.105
module load anaconda3/5.3.0
. /share/apps/anaconda3/5.3.0/etc/profile.d/conda.sh
conda activate dis_pytorch_env
python train.py
