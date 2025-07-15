#!/bin/bash
#FLUX: --job-name=buttery-dog-1292
#FLUX: --urgency=16

srun -c $SLURM_CPUS_PER_TASK singularity pull --disable-cache docker://tensorflow/tensorflow:latest-gpu
singularity exec --nv tensorflow_latest-gpu.sif python tf_test_multi_gpu.py
