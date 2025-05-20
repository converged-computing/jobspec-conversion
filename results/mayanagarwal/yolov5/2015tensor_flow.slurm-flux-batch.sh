#!/bin/bash
#FLUX: -N 1
#FLUX: --queue=shortgpgpu
#FLUX: -g 1
#FLUX: -t 00:05:00
#FLUX: -c 1
# Note: The Slurm account (--account hpcadmingpgpu) and specific GPU type (p100 from --gres=gpu:p100:1)
# do not have direct, standard equivalents in Flux batch directives.
# The GPU type is often implicit in the queue choice or handled by site-specific resource configurations.
# The account is typically managed outside the job script (e.g., user's project association).

module purge
source /usr/local/module/spartan_old.sh
module load Tensorflow/1.8.0-intel-2017.u2-GCC-6.2.0-CUDA9-Python-3.5.2-GPU

python tensor_flow.py