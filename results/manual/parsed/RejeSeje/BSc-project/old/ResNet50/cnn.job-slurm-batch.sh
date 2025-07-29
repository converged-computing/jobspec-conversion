#!/bin/bash
#SBATCH --job-name=bsc-cnn-job
#SBATCH --output=job.cnn.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=05:30:00

module load Anaconda3/2023.03-1
cd "/home/nizp/BSc-Project/ResNet50" 
source activate bachelor
SECONDS=0
echo "Running on $(hostname):"
python cnn_with_val.py
duration=$SECONDS
echo "All models took $(($duration / 60)) minutes and $(($duration % 60)) seconds to train."
