#!/bin/bash
#FLUX: --job-name=gen_image_var
#FLUX: -t=300
#FLUX: --urgency=16

hostname
nvidia-smi
/home/jrick6/.conda/envs/simclr/bin/python generate_image_variations.py \
    -tfp "/home/jrick6/tensorflow_datasets/imagenette_id/full-size-v2/1.0.0/imagenette-train.tfrecord-00015-of-00016" \
    -o "/home/jrick6/tensorflow_datasets/imagenette_id_variations1/full-size-v2/1.0.0/dir_imagenette-train.tfrecord-00015-of-00016/imagenette-train.tfrecord-00015-of-00016" \
    --input_id ${SLURM_ARRAY_TASK_ID}
