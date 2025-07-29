#!/bin/bash
#FLUX: --job-name=*CHANGE*
#FLUX: --queue=pfaendtner
#FLUX: -t=43200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load icc_17-impi_2017
source /gscratch/pfaendtner/sarah/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
source /gscratch/pfaendtner/sarah/scripts/activate_plumed2.4.2.sh
mpiexec.hydra -np 28 gmx_mpi mdrun -s topol.tpr -o traj.trr -x traj.xtc -cpi restart -cpo restart -c confout.gro -e ener.edr -g md.log -ntomp 1
exit 0
