#!/bin/bash
#FLUX: --job-name=memb_equil
#FLUX: -n=3
#FLUX: -c=8
#FLUX: --queue=volta-gpu
#FLUX: -t=54000
#FLUX: --urgency=16

unset OMP_NUM_THREADS
module purge
module load gcc/9.1.0
module load cuda/11.4
source /nas/longleaf/apps/gromacs/2021.5/avx2_256-cuda11.4/bin/GMXRC
minit=step5_input
rest_prefix=step5_input
mini_prefix=step6.0_minimization
equi_prefix=step6.%d_equilibration
prod_prefix=step7_production
prod_step=step7
lscpu
gmx_gpu grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${minit}.gro -r ${rest_prefix}.gro -p topol.top -n index.ndx
gmx_gpu mdrun -v -deffnm ${mini_prefix}
let cnt=1
let cntmax=6
while [ $cnt -le $cntmax ] ; do
  pcnt=$((cnt-1))
  istep=`printf ${equi_prefix} ${cnt}`
  pstep=`printf ${equi_prefix} ${pcnt}`
  if [ $cnt -eq 1 ]
  then
    pstep=${mini_prefix}
  fi
  gmx_gpu grompp -f ${istep}.mdp -o ${istep}.tpr -c ${pstep}.gro -r ${rest_prefix}.gro -p topol.top -n index.ndx
  gmx_gpu mdrun -v -deffnm ${istep} -ntmpi 3 -ntomp 8 -nb gpu -bonded gpu -pme gpu -npme 1
  ((cnt++))
done
