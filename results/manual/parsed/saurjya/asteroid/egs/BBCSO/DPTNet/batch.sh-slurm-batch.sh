#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=128000
#SBATCH --time=3-08:00:00
#SBATCH --qos=turing

module purge
module load baskerville
module load bask-apps/test
module load Miniconda3/4.10.3
module load cuDNN/8.0.4.30-CUDA-11.1.1
module load libsndfile
source activate asteroid1
which python
echo $CUDA_VISIBLE_DEVICES
./run.sh
