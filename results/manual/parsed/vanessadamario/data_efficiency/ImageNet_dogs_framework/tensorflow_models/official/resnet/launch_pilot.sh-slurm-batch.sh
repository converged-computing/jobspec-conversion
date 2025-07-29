#!/bin/bash
#SBATCH --job-name=resnet
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:tesla-k80:8
#SBATCH --mem=30GB
#SBATCH --time=03:00:00
#SBATCH --qos=cbmm
#SBATCH --array=0

export PYTHONPATH='$PYTHONPATH:/raid/poggio/home/vanessad/ImageNet_dogs_framework/tensorflow_models/official/resnet'

export PYTHONPATH="$PYTHONPATH:/raid/poggio/home/vanessad/ImageNet_dogs_framework/tensorflow_models/official/resnet"
singularity exec --nv /raid/poggio/home/xboix/containers/xboix-tensorflow1.14.simg \
python imagenet_main.py  \
--data_dir=/raid/poggio/home/vanessad/data/TFRecords \
--num_gpus=8 \
--batch_size=128 \
--train_epochs=90 \
--crop_image=True \
--model_dir=/raid/poggio/home/vanessad/resnet_experiments/foveation/ImageNet_dogs_framework/tensorflow_models/official/resnet/no_crop_all_data
