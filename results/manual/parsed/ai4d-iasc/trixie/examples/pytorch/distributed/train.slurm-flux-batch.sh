#!/bin/bash
#FLUX: --job-name=pytorch.distributed
#FLUX: -N=2
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: --queue=TrixieMain
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

readonly MASTER_ADDR_JOB=$SLURMD_NODENAME
readonly MASTER_PORT_JOB="12234"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
readonly srun='srun --output=%x-%j.%t.out'
env
$srun bash \
   task.sh \
      $MASTER_ADDR_JOB \
      $MASTER_PORT_JOB &
wait
