#!/bin/bash
#FLUX: --job-name=TensorFlow
#FLUX: --queue=gpu-shared
#FLUX: -t=3600
#FLUX: --urgency=16

module load singularity
singularity exec /share/apps/gpu/singularity/sdsc_ubuntu_gpu_tflow.img lsb_release -a
singularity exec /share/apps/gpu/singularity/sdsc_ubuntu_gpu_tflow.img python -m tensorflow.models.image.mnist.convolutional
