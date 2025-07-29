#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=02:00:00

date;hostname;pwd
module load singularity
singularity exec --nv --bind /blue/vendor-nvidia/hju/data/BTCV:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--logdir=/mnt \
--data_dir=/mnt --json_list=dataset_0.json \
--roi_x=96 --roi_y=96 --roi_z=96 --feature_size=48 \
--batch_size=1 \
--val_every=1 --max_epochs=2 \
--save_checkpoint \
--noamp
