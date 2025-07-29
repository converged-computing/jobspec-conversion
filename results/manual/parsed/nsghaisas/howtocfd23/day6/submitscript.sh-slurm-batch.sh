#!/bin/bash
#FLUX: --job-name=butterscotch-nalgas-8012
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load cuda/11.2
module load fftw/3.3.5
module load spack/0.17
module load nvhpc/22.1-gcc-11.2.0-axka
cd $SLURM_SBUMIT_DIR 
burger/burger.exe
