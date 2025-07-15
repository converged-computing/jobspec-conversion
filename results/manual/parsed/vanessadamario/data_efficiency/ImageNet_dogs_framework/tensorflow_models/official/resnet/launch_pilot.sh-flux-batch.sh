#!/bin/bash
#FLUX: --job-name=resnet
#FLUX: --priority=16

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
