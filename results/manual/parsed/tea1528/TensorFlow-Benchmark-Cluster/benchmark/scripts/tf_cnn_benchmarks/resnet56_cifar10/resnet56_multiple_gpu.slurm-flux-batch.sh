#!/bin/bash
#FLUX: --job-name=tart-pastry-1671
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --data_format=NCHW --batch_size=256 \
--model=resnet56 --optimizer=momentum --variable_update=replicated \
--nodistortions --num_gpus=4 \
--num_epochs=90 --weight_decay=1e-4 --data_dir=cifar10_data --use_fp16 \
--train_dir=cifar10_train --data_name=cifar10
