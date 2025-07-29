#!/bin/bash
#SBATCH --account=sc3260
#SBATCH --output=real_multiple_gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=20G
#SBATCH --time=20:00:00
#SBATCH --partition=maxwell

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python tf_cnn_benchmarks.py --data_format=NCHW --batch_size=256 \
--model=resnet56 --optimizer=momentum --variable_update=replicated \
--nodistortions --num_gpus=4 \
--num_epochs=90 --weight_decay=1e-4 --data_dir=cifar10_data --use_fp16 \
--train_dir=cifar10_train --data_name=cifar10
