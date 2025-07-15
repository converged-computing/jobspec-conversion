#!/bin/bash
#FLUX: --job-name=pusheena-parsnip-1192
#FLUX: -c=5
#FLUX: --queue=small
#FLUX: -t=86400
#FLUX: --priority=16

export FN='$(cd ..; basename -- "$PWD")'
export GMX='gmx'

module purge 
module load gromacs/2018.3 
export FN=$(cd ..; basename -- "$PWD")
export GMX=gmx
cp ../00-Prep/posre*.itp .
cp ../01-Min/min.gro .
cp ../01-Min/$FN.top .
cp ../00-Prep/index_$FN.ndx ./i.ndx
cp ../01-Min/lig*.itp .
$GMX grompp -f nvt.mdp -c min.gro -p $FN.top -o NVT.tpr -r min.gro -n i.ndx 
mpirun -np ${SLURM_NTASKS_PER_NODE} --bind-to socket \
	mdrun_mpi -s NVT.tpr -deffnm NVT -maxh 24.0  \
        -ntomp ${SLURM_CPUS_PER_TASK} &> run.out
echo Total-Energy | $GMX energy -f NVT.edr -o ${FN}_NVT_energy.xvg #extract energy of system
echo Temperature | $GMX energy -f NVT.edr -o ${FN}_NVT_temperature.xvg #extract temperature of system
echo 0 | $GMX trjconv -s NVT.tpr -f NVT.trr -o NVTed.gro -b 1000 -e 1000 -pbc whole #take the last frame of NVT for the next step: NPT
echo 0 | $GMX trjconv -s NVT.tpr -f NVT.trr -o NVT_reimaged.trr -pbc whole #reimage all of  NVT simulation
