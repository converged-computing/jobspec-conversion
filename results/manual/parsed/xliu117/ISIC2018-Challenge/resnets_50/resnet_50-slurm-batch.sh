#!/bin/bash
#SBATCH --job-name=resnet_50
#SBATCH --output=resnet50_model.%j
#SBATCH --mail-user=kaihe@tamu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=2

module load Keras/2.1.3-goolfc-2017b-Python-3.6.3
module load OpenCV/3.3.0-foss-2017b-Python-3.6.3
python /scratch/user/kaihe/ISIC/TASK3//resnet_50/resnet_50.py 
