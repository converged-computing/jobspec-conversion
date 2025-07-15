#!/bin/bash
#FLUX: --job-name=gen_image_var
#FLUX: --priority=16

hostname
nvidia-smi
/home/jrick6/.conda/envs/simclr/bin/python generate_image_variations.py \
    -tfp "/home/jrick6/tensorflow_datasets/imagenette_id/full-size-v2/1.0.0/imagenette-train.tfrecord-00010-of-00016" \
    -o "/home/jrick6/tensorflow_datasets/imagenette_id_variations0/full-size-v2/1.0.0/dir_imagenette-train.tfrecord-00010-of-00016/imagenette-train.tfrecord-00010-of-00016" \
    --input_id ${SLURM_ARRAY_TASK_ID}
