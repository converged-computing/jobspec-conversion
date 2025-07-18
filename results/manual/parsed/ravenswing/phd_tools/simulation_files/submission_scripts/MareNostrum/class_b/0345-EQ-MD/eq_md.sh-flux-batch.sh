#!/bin/bash
#FLUX: --job-name=eccentric-underoos-3106
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=86400
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
cp ../02-NVT/NVT.gro .
cp ../02-NVT/$FN.top .
cp ../01-Min/i.ndx .
cp ../01-Min/*.itp .
cp ../01-Min/min.tpr .
$GMX grompp -f npt.mdp -c NVT.gro -p $FN.top -o NPT.tpr -r NVT.gro -n i.ndx
srun gmx_mpi mdrun -s NPT.tpr -deffnm NPT
echo Total-Energy | $GMX energy -f NPT.edr -o ${FN}_NPT_energy.xvg      #extract energy of system
echo Temperature  | $GMX energy -f NPT.edr -o ${FN}_NPT_temperature.xvg #extract temperature of system
$GMX grompp -f npt2.mdp -c NPT.gro -p $FN.top -o NPT2.tpr -r NPT.gro -n i.ndx
srun gmx_mpi mdrun -s NPT2.tpr -deffnm NPT2
echo 12 0 | $GMX energy -f NPT2.edr -o ${FN}_tot_energy.xvg  #extract total energy of system
echo 13 0 | $GMX energy -f NPT2.edr -o ${FN}_temperature.xvg #extract temperature of system
echo 15 0 | $GMX energy -f NPT2.edr -o ${FN}_pressure.xvg    #extract pressure of system
$GMX  grompp -f md.mdp -c NPT2.gro -p $FN.top -o md.tpr -t NPT2.cpt -r NPT2.gro -n i.ndx -pp processed.top
srun gmx_mpi mdrun -s md.tpr -deffnm md -maxh 71.5
cp md.cpt md_1.cpt
cp md_prev.cpt md_1_prev.cpt
