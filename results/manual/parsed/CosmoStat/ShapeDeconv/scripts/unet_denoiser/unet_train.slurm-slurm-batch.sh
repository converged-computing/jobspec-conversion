#!/bin/bash
#SBATCH --job-name=unet_train
#SBATCH --output=unet_train%j.out
#SBATCH --error=unet_train%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=4-04:00:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=ntasks-per-node=1

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
cd $WORK/GitHub/ShapeDeconv/scripts/unet_denoiser
python ./unet_train.py --data_dir=/gpfswork/rech/xdy/uze68md/data/attrs2img_cosmos_parametric_cfht2hst/ --model_dir=/gpfswork/rech/xdy/uze68md/trained_models/model_cfht/ --n_col=64 --n_row=64 --batch_size=32 --steps=6500 --epochs=20
