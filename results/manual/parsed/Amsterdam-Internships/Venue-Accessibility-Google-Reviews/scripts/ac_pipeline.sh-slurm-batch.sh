#!/bin/bash
#SBATCH --job-name=AC-Baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:15:00
#SBATCH --partition=defq
#SBATCH --constraint=ntasks-per-node=1,TitanX

export LOCAL_ENV='/var/scratch/mbn781/Venue-Accessibility-Google-Reviews/'
export PATH='/path/to/cuda-11.1/bin:$PATH'
export LD_LIBRARY_PATH='/path/to/cuda-11.1/lib64:$LD_LIBRARY_PATH'
export TRAINING_MODE='simple'

module load cuda11.1/toolkit/11.1.1
module load cuDNN/cuda11.1/8.0.5
conda init bash
export LOCAL_ENV=/var/scratch/mbn781/Venue-Accessibility-Google-Reviews/
echo "LOCAL_ENV is set to: $LOCAL_ENV"
source ~/.bashrc
conda activate /var/scratch/mbn781/anaconda3/envs/BachelorsProject
export PATH=/path/to/cuda-11.1/bin:$PATH
export LD_LIBRARY_PATH=/path/to/cuda-11.1/lib64:$LD_LIBRARY_PATH
cd /var/scratch/mbn781/Venue-Accessibility-Google-Reviews
echo "Is the GPU being used..."
python "${LOCAL_ENV}scripts/gpu_test.py"
export TRAINING_MODE='simple'
source ./.env
nvidia-smi
echo "Preparing and cleaning data..."
nvidia-smi
echo "Making aspect label predictions on unseen data..."
python "${LOCAL_ENV}/src/aspect_classification/models/evaluate.py"
echo "Creating graphs of aspect evaluation metrics..."
python "${LOCAL_ENV}/src/aspect_classification/models/visualisations.py"
