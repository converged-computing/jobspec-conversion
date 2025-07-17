#!/bin/bash
#FLUX: --job-name=nvt
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

export FN='$(cd ..; basename -- "$PWD")'
export GMX='gmx_mpi'

module purge
module load intel/2020.1 
module load impi/2018.4 
module load mkl/2020.1 
module load boost/1.75.0 
module load plumed/2.8.0 
module load gromacs/2021.4-plumed.2.8.0
export FN=$(cd ..; basename -- "$PWD")
export GMX=gmx_mpi
cp ../01-Min/min_out.gro .
cp ../01-Min/$FN.top .
cp ../01-Min/*.itp . 
cp ../01-Min/i.ndx .
$GMX grompp -f nvt.mdp -c min_out.gro -p $FN.top -o NVT.tpr -r min_out.gro -n i.ndx
srun gmx_mpi mdrun -s NVT.tpr -deffnm NVT -maxh 2
echo Total-Energy | $GMX energy -f NVT.edr -o ${FN}_NVT_energy.xvg 
echo Temperature | $GMX energy -f NVT.edr -o ${FN}_NVT_temperature.xvg 
echo 0 | $GMX trjconv -s NVT.tpr -f NVT.trr -o NVTed.gro -b 1000 -e 1000 -pbc whole
