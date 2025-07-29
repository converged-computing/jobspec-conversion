#!/bin/bash
#SBATCH --job-name=finetune_resnet
#SBATCH --account=ganzha_23
#SBATCH --output=/home2/faculty/wjakubowski/logs/resnet/resnet_aug.log
#SBATCH --mail-user=wiktor.jakubowski.stud@pw.edu.pl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gpus-per-task=1
#SBATCH --mem=150G
#SBATCH --time=1-00:00:00

. /home2/faculty/wjakubowski/miniconda3/etc/profile.d/conda.sh
conda activate cnn
python /mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/src/models/resnet.py \
    --data "/mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/data/" \
    --outputdir "/mnt/evafs/groups/ganzha_23/wjakubowski/ConvolutionalNeuralNetworks/src/models"
