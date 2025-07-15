#!/bin/bash
#FLUX: --job-name=arid-lemur-1169
#FLUX: -N=4
#FLUX: -n=32
#FLUX: -t=300
#FLUX: --urgency=16

export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'

module swap PrgEnv-cray PrgEnv-gnu
module load python/3.8.0
module load dask
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
srun dask-mpi --no-nanny --nthreads 1  --local-directory=/project/kXX/XXXX/tickets/28242/workers${SLURM_JOBID} --scheduler-file=scheduler_${SLURM_JOBID}.json --interface=ipogif0 --scheduler-port=6192 &
sleep 30
python test_mpi_init_script.py
