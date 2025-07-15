#!/bin/bash
#FLUX: --job-name=spicy-lemur-4671
#FLUX: --urgency=16

export GMX='gmx_mpi'

module load cesga/2020 gcc/system openmpi/4.1.4_ft3_cuda gromacs/2021.4-plumed-2.8.0
export GMX=gmx_mpi
FN=$(cd ..; basename -- "$PWD")
traj=metad_${FN}
method=$(cd ../..; basename -- "$PWD")
$GMX grompp -f prod.mdp -c md.gro -p $FN.top -o prod.tpr -t md.cpt -r md.gro -n i.ndx -pp processed.top
srun $GMX mdrun -s prod.tpr -deffnm ${traj} -plumed ${FN}_${method}.dat -maxh 71.5
