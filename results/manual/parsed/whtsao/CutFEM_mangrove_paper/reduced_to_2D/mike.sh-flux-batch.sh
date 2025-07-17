#!/bin/bash
#FLUX: --job-name=cox_reduced_to_2D
#FLUX: -N=16
#FLUX: -n=1024
#FLUX: --queue=workq
#FLUX: -t=259200
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
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.csv .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun -l5 -v -p --TwoPhaseFlow cox_flume2DV.py -C "he=0.04 mangrove_porous=True filename='inp_HD_TR1.csv'"
date
exit 0
