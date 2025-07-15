#!/bin/bash
#FLUX: --job-name=lovable-pastry-3419
#FLUX: --priority=16

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
