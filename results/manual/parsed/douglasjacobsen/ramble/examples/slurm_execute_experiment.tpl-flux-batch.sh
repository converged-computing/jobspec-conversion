#!/bin/bash
#FLUX: --job-name=expressive-milkshake-5792
#FLUX: --urgency=16

export OMP_NUM_THREADS='{n_threads}'

cd {experiment_run_dir}
{spack_setup}
export OMP_NUM_THREADS={n_threads}
scontrol show hostnames ${SLURM_JOB_NODELIST} > hostfile
{command}
