#!/bin/bash
#FLUX: --job-name=*CHANGE*
#FLUX: --queue=pfaendtner
#FLUX: -t=43200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load icc_17-impi_2017
source /suppscr/pfaendtner/codes/gromacs18.3/gromacs-2018.3/bin/bin/GMXRC
source /suppscr/pfaendtner/codes/plumed-2.4.2_july2/plumed-2.4.2/sourceme.sh
mpiexec.hydra -np 16 gmx_mpi mdrun -s topol.tpr -o traj.trr -x traj.xtc -cpi restart -cpo restart -c confout.gro -e ener.edr -g md.log -ntomp 1
exit 0
