#!/bin/bash
#FLUX: --job-name=gloopy-staircase-2013
#FLUX: -t=1800
#FLUX: --priority=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/home/simont/mars'

module load gcc/9.3
module load fftw/3.3.8-gcc9
module load openblas/openblas_gcc9
module load libffi/3.3
module load python/3.8.2-gcc9
gcc -O3 -o libalbatrostools.so -fPIC --shared albatrostools.c -fopenmp
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/home/simont/mars
python3 radio.py
