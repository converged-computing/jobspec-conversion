#!/bin/bash
#FLUX: --job-name=moolicious-spoon-6165
#FLUX: --priority=16

ml PDC/22.06
ml matlab/r2023a
echo "Script initiated at `date` on `hostname`"
matlab -nodisplay -nodesktop -nosplash spectral_serial.m your_matlab_program.out
echo "Script finished at `date` on `hostname`"
