#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: -n=24
#FLUX: --queue=scavenge
#FLUX: -t=1200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module purge
echo "Job started on `hostname` at `date`"
echo "SLURM_JOBID="$SLURM_JOBID
ml intel/2018b LAMMPS/7Aug2019
srun lmp_mpi -nc -l my.log -var seed `echo $RANDOM` -i in.reaxc
echo "Job finished on `hostname` at `date`"
