#!/bin/bash
#FLUX: --job-name=RY1_MIN1
#FLUX: -n=28
#FLUX: -c=3
#FLUX: --exclusive
#FLUX: --queue=high_priority
#FLUX: -t=180000
#FLUX: --urgency=16

export OMP_PROC_BIND='close'

module purge > /dev/null 2>&1
source ~/.bashrc 
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job NAME is $SLURM_JOB_NAME
echo Slurm job ID is $SLURM_JOBID
conda --version
cd $SLURM_SUBMIT_DIR
conda activate cocoapy38
source start_cocoa
export OMP_PROC_BIND=close
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
else
  export OMP_NUM_THREADS=1
fi
mpirun -n ${SLURM_NTASKS} --oversubscribe --mca btl vader,tcp,self --bind-to core:overload-allowed --map-by numa:pe=${OMP_NUM_THREADS} cobaya-run ./projects/lsst_y1/EXAMPLE_MIN${SLURM_ARRAY_TASK_ID}.yaml -f
