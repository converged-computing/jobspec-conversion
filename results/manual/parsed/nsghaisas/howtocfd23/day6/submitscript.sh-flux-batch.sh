#!/bin/bash
#FLUX: --job-name=pusheena-poo-0450
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module load cuda/11.2
module load fftw/3.3.5
module load spack/0.17
module load nvhpc/22.1-gcc-11.2.0-axka
cd $SLURM_SBUMIT_DIR 
burger/burger.exe
