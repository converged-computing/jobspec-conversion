#!/bin/bash
#FLUX: --job-name=memb_smd
#FLUX: -n=3
#FLUX: -c=8
#FLUX: --queue=volta-gpu
#FLUX: -t=28800
#FLUX: --priority=16

unset OMP_NUM_THREADS
module purge
module load gcc/9.1.0
module load cuda/11.4
source /nas/longleaf/apps/gromacs/2021.5/avx_512-cuda11.4/bin/GMXRC.bash
minit=step5_input
rest_prefix=step5_input
mini_prefix=step6.0_minimization
equi_prefix=step6.%d_equilibration
prod_prefix=step7_production
prod_step=step7
lscpu
uname -a
gmx_gpu grompp -f step7_smd_cylinder.mdp -o step7_smd_cylinder.tpr -c step6.6_equilibration.gro -p topol.top -n index.ndx -maxwarn 1
gmx_gpu mdrun -v -deffnm step7_smd_cylinder -ntmpi 3 -ntomp 8 -nb gpu -bonded gpu -pme gpu -npme 1
