#!/bin/bash
#SBATCH --job-name=udacity_new_xml_test_train
#SBATCH --output=./out/%x_%u_%j.out
#SBATCH --error=./out/%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=30G
#SBATCH --partition=mhigh,mlow

export CUDA_LAUNCH_BLOCKING='1'

nvidia-smi
export CUDA_LAUNCH_BLOCKING=1
LEARNING_RATE=1e-3
BATCH_SIZE=1
DECAY_STEP=5
python3 test_net.py --dataset pascal_voc --net res101 \
                       --cuda --mGPUs --checksession 1 --checkepoch 20 --checkpoint 2504
