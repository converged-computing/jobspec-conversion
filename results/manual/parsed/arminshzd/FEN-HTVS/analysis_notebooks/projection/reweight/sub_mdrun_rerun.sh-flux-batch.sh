#!/bin/bash
#FLUX: --job-name=buttery-citrus-0939
#FLUX: -c=5
#FLUX: --exclusive
#FLUX: --queue=gm4-pmext
#FLUX: -t=129600
#FLUX: --priority=16

NCPU=$(($SLURM_NTASKS_PER_NODE))
NTHR=$(($SLURM_CPUS_PER_TASK))
NNOD=$(($SLURM_JOB_NUM_NODES))
NP=$(($NCPU * $NNOD * $NTHR))
module unload openmpi gcc cuda python
module load openmpi/4.1.1+gcc-10.1.0 cuda/11.2
source /project/andrewferguson/armin/grom_new/gromacs-2021.6/installed-files-mw2-256/bin/GMXRC
gmx mdrun -ntomp "$NP" -plumed reweight.dat -s ../md.tpr -rerun ../md.xtc
