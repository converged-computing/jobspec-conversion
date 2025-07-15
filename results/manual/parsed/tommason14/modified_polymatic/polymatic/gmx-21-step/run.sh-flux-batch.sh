#!/bin/bash
#FLUX: --job-name=scruptious-truffle-9023
#FLUX: --urgency=16

export OMP_NUM_THREADS='48'

export OMP_NUM_THREADS=48
module load gromacs/2019.6
gmx grompp -f 1.mdp -c ../npt.gro -p ../topol.top -o 1.tpr -maxwarn 2
ibrun mdrun_mpi -s 1.tpr -deffnm 1 -g 1.log
for step in {2..21}
do
  prev=$((step-1))
  gmx grompp -f $step.mdp -c $prev.gro -t $prev.cpt -p ../topol.top -o $step.tpr -maxwarn 2
  ibrun mdrun_mpi -s $step.tpr -deffnm $step -g $step.log
done
echo 0 | gmx trjconv -f 21.cpt -s 21.tpr -o last_step.gro
echo 0 | gmx trjconv -f 21.cpt -s 21.tpr -o last_step_unwrapped.gro -pbc mol
