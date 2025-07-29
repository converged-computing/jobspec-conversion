#!/bin/bash
#SBATCH --job-name=$USER-pcdet
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00

NUM_GPU=2
TIMEOUT="240:00:00"
project="pcdet"
image="nvidia/cuda:10.0-base"
KITTI_BASE_PATH="/data/projects/2020_trn_Datasets/PublicDatasets/KITTI/3D-object-detection"
PCDET_BASE_PATH="/data/projects/2020_trn_pcdet"
CONFIG_PATH="second.yml"
srun --gres=gpu:volta:$NUM_GPU \
     --job-name "$USER-$project" \
     --time $TIMEOUT \
     --container-image=$image \
     --container-workdir=/root \
     --container-mounts="$KITTI_BASE_PATH/testing:/kitti/testing,$PCDET_BASE_PATH:/root,$KITTI_BASE_PATH/training:/kitti/training" \
     bash -c "echo $USER ; nvidia-smi ; ls /root ; ls  /kitti/training ; pwd ; ls /kitti/testing"
