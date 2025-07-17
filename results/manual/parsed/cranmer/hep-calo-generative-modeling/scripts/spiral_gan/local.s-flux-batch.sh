#!/bin/bash
#FLUX: --job-name=local
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

module purge
module load cuda/8.0.44
module load cudnn/8.0v5.1
module load pillow/intel/4.0.0
module load h5py/intel/2.7.0rc2
module load tensorflow/python2.7/20170218
module load scikit-image/intel/0.12.3
cd /scratch/akp258/udon/scripts/spiral_gan/
python -u local.py local.cfg
