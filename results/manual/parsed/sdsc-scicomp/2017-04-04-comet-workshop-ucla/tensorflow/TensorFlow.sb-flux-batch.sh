#!/bin/bash
#FLUX: --job-name="TensorFlow"
#FLUX: --queue=gpu-shared
#FLUX: --priority=16

module load singularity
singularity exec /share/apps/gpu/singularity/sdsc_ubuntu_gpu_tflow.img lsb_release -a
singularity exec /share/apps/gpu/singularity/sdsc_ubuntu_gpu_tflow.img python -m tensorflow.models.image.mnist.convolutional
