#!/bin/bash
#FLUX: --job-name=peachy-platanos-9291
#FLUX: -N=2
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/groups/bevanlab/software/cascades/gromacs/2019.3/lib64'

module load gcc/7.3.0
module load cuda/10.0.130
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/groups/bevanlab/software/cascades/gromacs/2019.3/lib64
source /groups/bevanlab/software/cascades/gromacs/2019.3/bin/GMXRC
