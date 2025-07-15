#!/bin/bash
#FLUX: --job-name=ld1-dihedral-bias-opes_actin
#FLUX: -N=8
#FLUX: -t=216000
#FLUX: --priority=16

source /scratch/work/hockygroup/software/gromacs-2019.6-plumedSept2020/bin/GMXRC.bash.modules.triasha
gmxexe=/scratch/work/hockygroup/software/gromacs-2019.6-plumedSept2020/bin/gmx_mpi
srun $gmxexe mdrun -s actin-gatpu_ionized_npt_20ns_every50ps-g5.1.4_5mus.tpr -deffnm opes_ld1_bf_12.0_barrier_15.0 -plumed plumed.dat -cpi opes_ld1_bf_12.0_barrier_15.0.cpt -append -nsteps 25000000 -ntomp 1
