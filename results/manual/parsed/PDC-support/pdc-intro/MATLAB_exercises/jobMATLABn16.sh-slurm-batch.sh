#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -n=16
#FLUX: --queue=shared
#FLUX: -t=3600
#FLUX: --urgency=16

ml PDC/22.06
ml matlab/r2023a
echo "Script initiated at `date` on `hostname`"
matlab -nodisplay -nodesktop -nosplash spectral_serial.m your_matlab_program.out
echo "Script finished at `date` on `hostname`"
