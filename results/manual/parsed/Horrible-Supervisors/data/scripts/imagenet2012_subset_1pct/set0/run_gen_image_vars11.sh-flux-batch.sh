#!/bin/bash
#FLUX: --job-name=gen_image_var
#FLUX: -t=300
#FLUX: --urgency=16

hostname
nvidia-smi
/home/jrick6/.conda/envs/simclr/bin/python generate_image_variations.py \
    -tfp "/home/jrick6/tensorflow_datasets/imagenet2012_subset_id/1pct/5.0.0/imagenet2012_subset-train.tfrecord-00011-of-00016" \
    -o "/home/jrick6/tensorflow_datasets/imagenet2012_subset_id_variations0/1pct/5.0.0/dir_imagenet2012_subset-train.tfrecord-00011-of-00016/imagenet2012_subset-train.tfrecord-00011-of-00016" \
    --input_id ${SLURM_ARRAY_TASK_ID}
