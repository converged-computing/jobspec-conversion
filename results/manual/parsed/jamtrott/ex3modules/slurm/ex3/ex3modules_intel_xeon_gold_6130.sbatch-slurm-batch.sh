#!/bin/bash
#SBATCH --job-name=ex3modules_intel_xeon_gold_6130
#SBATCH --output=slurm/ex3/jobs/%j-%x-out.txt
#SBATCH --error=slurm/ex3/jobs/%j-%x-err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00
#SBATCH --partition=xeongold16q

JOBS=$((${SLURM_NTASKS}*${SLURM_CPUS_PER_TASK}))
echo "SLURM_JOB_NAME=${SLURM_JOB_NAME}" >&2
echo "SLURM_JOB_ID=${SLURM_JOB_ID}" >&2
echo "SLURM_SUBMIT_HOST=${SLURM_SUBMIT_HOST}" >&2
echo "SLURM_NTASKS=${SLURM_NTASKS}" >&2
echo "SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}" >&2
echo "SLURM_JOB_NUM_NODES=${SLURM_JOB_NUM_NODES}" >&2
echo "SLURM_JOB_NODELIST=${SLURM_JOB_NODELIST}" >&2
echo "PWD=${PWD}" >&2
echo "PATH=${PATH}" >&2
echo "TMPDIR=${TMPDIR}" >&2
echo "SHELL=${SHELL}" >&2
echo "CC=${CC}" >&2
echo "CFLAGS=${CFLAGS}" >&2
echo "JOBS=${JOBS}" >&2
set -x
uname -a >&2
lscpu >&2
lstopo >&2
numactl --hardware >&2
numactl --show >&2
{ set +x; } 2>/dev/null
set -x
./ex3modules -v -j${JOBS} "$@"
{ set +x; } 2>/dev/null
