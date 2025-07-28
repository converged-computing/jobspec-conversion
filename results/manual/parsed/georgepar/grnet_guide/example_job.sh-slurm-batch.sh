#!/bin/bash
#FLUX: --job-name=test_job
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

export I_MPI_FABRICS='shm:dapl'

export I_MPI_FABRICS=shm:dapl
if [ x$SLURM_CPUS_PER_TASK == x ]; then
  export OMP_NUM_THREADS=1
else
  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
fi
module purge            # clean up loaded modules 
module use ${HOME}/modulefiles
module load gnu/8.3.0
module load intel/18.0.5
module load intelmpi/2018.5
module load cuda/10.1.168
module load python/3.6.5
module load pytorch/1.3.1
module load slp/1.3.1
srun python test.py
