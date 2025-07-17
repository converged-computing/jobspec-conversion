#!/bin/bash
#FLUX: --job-name=evasive-spoon-1528
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
gmx mdrun -ntomp "$NP" -s md.tpr -cpi md.cpt -deffnm md -plumed plumed_restart.dat -maxh 36
