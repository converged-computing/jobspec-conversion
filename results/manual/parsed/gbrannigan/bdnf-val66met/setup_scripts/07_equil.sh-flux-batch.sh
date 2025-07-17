#!/bin/bash
#FLUX: --job-name=V4
#FLUX: -n=64
#FLUX: --queue=normal
#FLUX: -t=19800
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1'

module purge
module load intel/15.0.2
module load mvapich2/2.1
module load boost
module load gromacs/5.1.2
module list
export GMX_MAXBACKUP=-1
module list
mdp=/scratch/02780/ruchi/trex-03/mdp_files
echo "13" > ../inp
ibrun -np 1  gmx grompp -f $mdp/em.mdp -c eq_vol.gro -p topol.top -o em_vol.tpr >& grompp_9.out && \
ibrun -np 64 mdrun_mpi -deffnm em_vol  && \
ibrun -np  1 gmx grompp -f $mdp/nvt.mdp -c em_vol.gro -p topol.top -o nvt_vol.tpr >& grompp_10.out && \
ibrun -np 64 mdrun_mpi -deffnm nvt_vol 
