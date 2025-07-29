#!/bin/bash
#SBATCH --job-name=test_LibRPA
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo Working directory is $PWD
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
echo Begin Time: `date`
workdir=$(basename `pwd`)
mpirun /home/rongshi/new_abacus_LibRPA/LibRPA/chi0_main.exe 14 0 > LibRPA_$workdir.$SLURM_JOB_ID.out
echo End Time: `date`
