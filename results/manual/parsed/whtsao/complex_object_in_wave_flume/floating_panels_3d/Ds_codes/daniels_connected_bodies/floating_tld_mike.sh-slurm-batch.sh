#!/bin/bash
#FLUX: --job-name=emi2023_3d_floating_tld
#FLUX: -N=8
#FLUX: -n=384
#FLUX: --queue=workq
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}'
export MV2_HOMOGENEOUS_CLUSTER='1'

date
module purge
module load proteus/fct
module load intel/2021.5.0
module load mvapich2/2.3.7/intel-2021.5.0
module load gcc/11.2.0
export LD_LIBRARY_PATH=/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}
export MV2_HOMOGENEOUS_CLUSTER=1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp $SLURM_SUBMIT_DIR/*.stl .
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun TN_with_box_so.py -F -l 5 -C "he=1. T=3."  #-O petsc.options.asm
date
exit 0
