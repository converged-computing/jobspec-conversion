#!/bin/bash
#FLUX: --job-name=pp
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --urgency=16

export FN='$(basename -- "$PWD")'
export GMX='gmx_mpi'

module purge
module load intel/2020.1
module load impi/2018.4
module load mkl/2020.1
module load boost/1.75.0
module load plumed/2.8.0
module load gromacs/2021.4-plumed.2.8.0
export FN=$(basename -- "$PWD")
export GMX=gmx_mpi
tpr=min.tpr
traj=md
ndx=i.ndx
tmax=200000
echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}.xtc       -o ${traj}_whole.xtc -pbc whole -n i.ndx
echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_whole.xtc -o ${traj}_clust.xtc -pbc cluster -n i.ndx
echo Protein Protein_LIG | $GMX trjconv -s $tpr -f ${traj}_clust.xtc -o ${traj}_final.xtc -pbc mol -ur compact -center -n i.ndx
echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_short.xtc -dt 100 -n i.ndx
echo Protein_LIG         | $GMX trjconv -s $tpr -f ${traj}_final.xtc -o ${FN}_lastframe.pdb -b $tmax -e $tmax -n i.ndx
echo Backbone Backbone   | $GMX rms     -s $tpr -f ${traj}_final.xtc -o backbone_rmsd.xvg -fit rot+trans -n i.ndx
echo Backbone MOL        | $GMX rms     -s $tpr -f ${traj}_final.xtc -o ligand_rmsd.xvg   -fit rot+trans -n i.ndx
