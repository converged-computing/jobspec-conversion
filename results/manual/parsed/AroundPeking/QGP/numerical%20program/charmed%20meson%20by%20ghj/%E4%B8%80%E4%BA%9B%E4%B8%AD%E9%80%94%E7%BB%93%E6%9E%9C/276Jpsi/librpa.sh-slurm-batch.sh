#!/bin/bash
#FLUX: --job-name=test_LibRPA
#FLUX: -c=48
#FLUX: --queue=640
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo Working directory is $PWD
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
echo Begin Time: `date`
workdir=$(basename `pwd`)
mpirun /home/rongshi/new_abacus_LibRPA/LibRPA/chi0_main.exe 14 0 > LibRPA_$workdir.$SLURM_JOB_ID.out
echo End Time: `date`
