#!/bin/bash
#FLUX: --job-name=resnet50
#FLUX: -c=32
#FLUX: --urgency=16

srun --container-image $1 \
 --container-mounts $2:/imagenet \
 --no-container-entrypoint \
 --mpi pmix \
 --ntasks $3 \
 /bin/bash -c \
 "python ./main.py \
 --mode $4 \
 --batch_size 256 \
 --data_dir /imagenet/result \
 --results_dir /results"
