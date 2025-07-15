#!/bin/bash
#FLUX: --job-name=SingleMD
#FLUX: --urgency=16

module load fftw2/intel/float/2.1.5  #Not sure about that one  
module load cuda/10.2                   
module load gromacs/2019/gmx  
gmx  mdrun  -s md.tpr -nice 0 -c md.gro  -nt 3  -ntmpi 1  -append -cpi state.cpt;
