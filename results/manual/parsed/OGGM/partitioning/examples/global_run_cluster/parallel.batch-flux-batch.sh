#!/bin/bash
#FLUX: --job-name=partitioning_test1
#FLUX: --exclusive
#FLUX: --queue=low
#FLUX: --priority=16

export OGGM_DOWNLOAD_CACHE='/home/data/download'
export OGGM_DOWNLOAD_CACHE_RO='1'

module load python/3.6.1 oggm-binary-deps/1
source /home/users/julia/python3_env/bin/activate
S_WORKDIR="/work/$SLURM_JOB_USER/partitioning_region_$SLURM_ARRAY_TASK_ID"
mkdir -p "$S_WORKDIR"
echo "Workdir for this run: $S_WORKDIR"
echo  "$SLURM_ARRAY_TASK_ID"
REGION=$SLURM_ARRAY_TASK_ID
RGI_DATA="/home/data/download/www.glims.org/RGI/rgi60_files"
export S_WORKDIR
export REGION
export OGGM_DOWNLOAD_CACHE="/home/data/download"
export OGGM_DOWNLOAD_CACHE_RO=1
export RGI_DATA
srun -n 1 -c "${SLURM_JOB_CPUS_PER_NODE}" python3 ./run.py
echo "DONE"
OUTDIR="${SLURM_SUBMIT_DIR}/out/global_partitioning"
mkdir -p "$OUTDIR"
cp -r "${S_WORKDIR}" "${OUTDIR}"
