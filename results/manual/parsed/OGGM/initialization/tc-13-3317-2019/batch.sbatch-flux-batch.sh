#!/bin/bash
#FLUX: --job-name=reconstruction
#FLUX: --exclusive
#FLUX: --queue=low
#FLUX: --priority=16

export OGGM_DOWNLOAD_CACHE='/home/data/download'
export OGGM_DOWNLOAD_CACHE_RO='1'

module load python/3.6.4 oggm-binary-deps/1
source /home/users/julia/python3_env/bin/activate
S_WORKDIR="/work/$SLURM_JOB_USER/paper"
mkdir -p "$S_WORKDIR"
echo "Workdir for this run: $S_WORKDIR"
echo "$SLURM_ARRAY_TASK_ID"
I=$SLURM_ARRAY_TASK_ID
export S_WORKDIR
export I
export OGGM_DOWNLOAD_CACHE="/home/data/download"
export OGGM_DOWNLOAD_CACHE_RO=1
export SLURM_ARRAY_TASK_ID
echo "$SLURM_ARRAY_TASK_ID"
srun -n 1 -c "${SLURM_JOB_CPUS_PER_NODE}" python3 ./alps.py
echo "DONE"
OUTDIR="/home/users/julia/reconstruction/out"
mkdir -p "$OUTDIR"
cp -r "${S_WORKDIR}" "${OUTDIR}"
