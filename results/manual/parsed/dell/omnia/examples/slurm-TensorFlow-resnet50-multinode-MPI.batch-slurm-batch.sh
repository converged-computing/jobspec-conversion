#!/bin/bash
#SBATCH --job-name=TF-resnet50
#SBATCH --output=%J-tf-resnet50.txt
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

mpirun  \ 
      --map-by numa  \
      python  \
      /foo/tensorflow/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py  \
      --batch_size=512  \
      --model=resnet50  \
      --variable_update=horovod  \
      --optimizer=momentum  \
      --nodistortions  \
      --gradient_repacking=8  \
      --weight_decay=1e-4  \
      --use_fp16=true  \
      --data_dir=/data/tensorflow/  \
      --data_name=imagenet
