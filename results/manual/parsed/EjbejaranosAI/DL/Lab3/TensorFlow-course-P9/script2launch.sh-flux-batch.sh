#!/bin/bash
#FLUX: --job-name= multiGPUproof
#FLUX: -c=40
#FLUX: -t=120
#FLUX: --urgency=16

module purge; module load ffmpeg/4.0.2 gcc/6.4.0 cuda/9.1 cudnn/7.1.3 openmpi/3.0.0 atlas/3.10.3 scalapack/2.0.2 fftw/3.3.7 szip/2.1.1 opencv/3.4.1 python/3.6.5_ML 
python multilayer_modified.py
