#!/bin/bash
#FLUX: --job-name=fat-salad-0736
#FLUX: -c=32
#FLUX: -t=259200
#FLUX: --urgency=16

export GMX='gmx_mpi'

module load cesga/2020 gcc/system openmpi/4.1.4_ft3_cuda gromacs/2021.4-plumed-2.8.0
export GMX=gmx_mpi
tmax=500000
FN=$(cd ..; basename -- "$PWD")
traj=metad_${FN}
method=$(cd ../..; basename -- "$PWD")
tpr=prod.tpr
ndx=i.ndx
$GMX convert-tpr -s prod.tpr -until $tmax -o $tpr
srun $GMX mdrun -s $tpr -deffnm ${traj} -cpi ${traj}.cpt -append -plumed ${FN}_${method}.dat -maxh 71.5
num=2
cp ${traj}.cpt ${traj}_${num}.cpt
cp ${traj}_prev.cpt ${traj}_${num}_prev.cpt
if [ ! -f ${traj}.gro ]; then bash CONTINUE.sh;
else
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}.xtc       -o ${traj}_whole.xtc -pbc whole -n i.ndx
    echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_whole.xtc -o ${traj}_clust.xtc -pbc cluster -n i.ndx
    echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_clust.xtc -o ${traj}_final.xtc -pbc mol -ur compact -center -n i.ndx
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_short.xtc -dt 10 -n i.ndx
    echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_lastframe.pdb -b $tmax -e $tmax -n i.ndx
fi
