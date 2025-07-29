#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64g
#SBATCH --time=3-00:00:00

module load CUDA/10.1
module load cuDNN/7.6.5/CUDA-10.1
module load gcc
pushd /data/rays3/locust_tracking/yolact
python train.py --config=babylocust_config --resume=weights/babylocust_resnet101_25999_78000.pth --start_iter=-1 --batch_size=8 --save_interval=1000 --keep_latest 
echo "Finished training"
popd
