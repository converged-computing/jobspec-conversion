#!/bin/bash
#FLUX: --job-name=panel_in_wind
#FLUX: -N=16
#FLUX: -n=1024
#FLUX: --queue=workq
#FLUX: -t=68400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}'
export MV2_HOMOGENEOUS_CLUSTER='1'

date
module load proteus/fct
export LD_LIBRARY_PATH=/home/packages/compilers/intel/compiler/2022.0.2/linux/compiler/lib/intel64_lin:${LD_LIBRARY_PATH}
export MV2_HOMOGENEOUS_CLUSTER=1
mkdir -p $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cd $SLURM_SUBMIT_DIR
cp *.py $WORK/$SLURM_JOB_NAME.$SLURM_JOBID 
cp *.pyx $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp *.asm $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp *.sh $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp *.stl $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cp *.csv $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
cd $WORK/$SLURM_JOB_NAME.$SLURM_JOBID
python setup.py build_ext -i
srun parun nse_p.py nse_n.py -F -l 5 -C "he=0.06" -O petsc.options.asm #-D pcube
exit 0
