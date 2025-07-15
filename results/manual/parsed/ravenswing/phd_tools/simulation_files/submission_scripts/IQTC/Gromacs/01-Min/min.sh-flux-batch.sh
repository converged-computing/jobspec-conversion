#!/bin/bash
#FLUX: --job-name=min
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

export name='$(cd ..; basename -- "$PWD")'
export GMX='gmx_mpi'

module purge
module load intel/2020.1 
module load impi/2018.4 
module load mkl/2020.1 
module load boost/1.75.0 
module load plumed/2.8.0 
module load gromacs/2021.4-plumed.2.8.0
export name=$(cd ..; basename -- "$PWD")
export GMX=gmx_mpi
$GMX grompp -f min.mdp -c $name.gro -p $name.top -o min.tpr -n i.ndx
srun gmx_mpi mdrun -s min.tpr -deffnm min -maxh 1
echo 10 0 | $GMX energy -f min.edr -o ${name}_min_energy.xvg
echo 0 | $GMX trjconv -s min.tpr -f min.trr -o min_out.gro -pbc whole
echo 0 | $GMX trjconv -s min.tpr -f min.trr -o ${name}_minimised.pdb -pbc mol -ur compact
echo Protein_LIG | $GMX trjconv -s min.tpr -f min.trr -o ${name}_minimised_dry.pdb -pbc mol -ur compact -n i.ndx
