#!/bin/bash
#FLUX: --job-name=DCTST
#FLUX: -N=16
#FLUX: -n=384
#FLUX: --exclusive
#FLUX: --queue=cpu_small
#FLUX: -t=3600
#FLUX: --urgency=16

mkdir -p log tmp
NETINFO=log/netinfo.$SLURM_JOBID.log
echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
echo -n Entering in: 
pwd
cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_HOST >> $NETINFO
ip addr >> $NETINFO
echo Loading modules
module load python/3.8.2
module load raxml/8.2_openmpi-2.0_gnu
source /scratch/app/modulos/julia-1.5.1.sh
cd /scratch/cenapadrjsd/diego.carvalho/biocomp
echo Starting Parsil Script
python3 parsl_inside_allocation.py
