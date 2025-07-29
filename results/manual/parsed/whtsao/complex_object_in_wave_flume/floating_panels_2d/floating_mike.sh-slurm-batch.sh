#!/bin/bash
#FLUX: --job-name=floating_panels_2d
#FLUX: -N=4
#FLUX: -n=256
#FLUX: --queue=workq
#FLUX: -t=1800
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
cp $SLURM_SUBMIT_DIR/petsc.options.superlu_dist .
cp $SLURM_SUBMIT_DIR/*.py .
cp $SLURM_SUBMIT_DIR/*.sh .
srun parun --TwoPhaseFlow floating_panels.py -F -l 5 -C "he=0.1 bodybool2=True linkbool=False mooring=True"
exit 0
