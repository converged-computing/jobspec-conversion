#!/bin/bash
#FLUX: --job-name=tax5_400_450
#FLUX: -N=2
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/home/kelsieking23/software/gromacs/4.6.5/bin'

module load intel
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/groups/bevanlab/software/cascades/fftw/3.3.8/lib:/home/kelsieking23/software/gromacs/4.6.5/bin
source /home/kelsieking23/software/gromacs/4.6.5/bin/GMXRC
