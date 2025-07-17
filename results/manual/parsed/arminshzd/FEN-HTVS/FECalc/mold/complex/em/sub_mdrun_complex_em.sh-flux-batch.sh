#!/bin/bash
#FLUX: --job-name=hairy-spoon-0331
#FLUX: -c=5
#FLUX: --queue=gm4-pmext
#FLUX: -t=129600
#FLUX: --urgency=16

NCPU=$(($SLURM_NTASKS_PER_NODE))
NTHR=$(($SLURM_CPUS_PER_TASK))
NNOD=$(($SLURM_JOB_NUM_NODES))
NP=$(($NCPU * $NNOD * $NTHR))
module unload openmpi gcc cuda python
module load openmpi/4.1.1+gcc-10.1.0 cuda/11.2
source /project/andrewferguson/armin/grom_new/gromacs-2021.6/installed-files-mw2-256/bin/GMXRC
gmx editconf -f complex.pdb -o complex_box.gro -c -bt cubic -box 5
gmx solvate -cp complex_box.gro -cs spc216.gro -o complex_sol.gro -p topol.top
CHARGE=$1
echo "System total charge: $CHARGE"
if [ $CHARGE -ne 0 ]
then
    gmx grompp -f ions.mdp -c complex_sol.gro -p topol.top -o ions.tpr -maxwarn 2
    gmx genion -s ions.tpr -o complex_sol_ions.gro -p topol.top -pname NA -nname CL -neutral << EOF
5
EOF
    gmx grompp -f em.mdp -c complex_sol_ions.gro -p topol.top -o em.tpr -maxwarn 1
else
    gmx grompp -f em.mdp -c complex_sol.gro -p topol.top -o em.tpr -maxwarn 1
fi
gmx mdrun -ntomp "$NP" -deffnm em
