#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=4
#FLUX: --queue=gpgpu
#FLUX: -t=600
#FLUX: --urgency=16

module load Python/3.5.2-intel-2017.u2-GCC-6.2.0-CUDA9
module load Tensorflow/1.10.0-intel-2017.u2-GCC-6.2.0-CUDA9-Python-3.5.2-GPU
python read_cifar.py > job_read_cifar.txt
