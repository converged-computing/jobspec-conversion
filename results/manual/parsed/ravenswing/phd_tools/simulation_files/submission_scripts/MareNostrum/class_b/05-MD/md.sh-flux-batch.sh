#!/bin/bash
#FLUX: --job-name=ornery-pancake-0809
#FLUX: -N=2
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
$GMX  grompp -f md.mdp -c $FN.gro -p $FN.top -o md.tpr -r $FN.gro -n i.ndx -pp processed.top
srun gmx_mpi mdrun -s md.tpr -deffnm md -maxh 71.5
cp md.cpt md_1.cpt
cp md_prev.cpt md_1_prev.cpt
