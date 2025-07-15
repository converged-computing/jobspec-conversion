#!/bin/bash
#FLUX: --job-name=hairy-destiny-7519
#FLUX: --priority=16

export GMX='gmx_mpi'

module load cesga/2020 gcc/system openmpi/4.1.4_ft3_cuda gromacs/2021.4-plumed-2.8.0
export GMX=gmx_mpi
FN='brd4_4hbv'
traj=metad_${FN}
method=$(cd ..; basename -- "$PWD")
$GMX grompp -f prod.mdp -c $FN.gro -p $FN.top -o prod.tpr -t md.cpt -r $FN.gro -n i.ndx -pp processed.top
srun $GMX mdrun -s prod.tpr -deffnm ${traj} -plumed ${FN}_${method}.dat -maxh 23.5
