#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

date;hostname;pwd
module load singularity
singularity exec --nv --bind /blue/vendor-nvidia/hju/data/BraTS2021:/mnt \
/blue/vendor-nvidia/hju/monaicore0.9.1 \
python main.py \
--json_list=/mnt/brats21_folds.json --data_dir=/mnt \
--roi_x=128 --roi_y=128 --roi_z=128 --in_channels=4 --spatial_dims=3 \
--feature_size=48 \
--val_every=1 --max_epochs=2 \
--use_checkpoint --noamp --save_checkpoint
