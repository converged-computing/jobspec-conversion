#!/bin/bash
#FLUX: --job-name=JNAME
#FLUX: -t=129600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
imodule load icc_17-impi_2017
module load cuda/9.1.85.3
source /gscratch/pfaendtner/sarah/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
source /gscratch/pfaendtner/jpfaendt/codes/plumed2/sourceme.sh
gmx_mpi mdrun -plumed plumed.dat -cpi -append -cpt 1 &>log.txt
exit 0
