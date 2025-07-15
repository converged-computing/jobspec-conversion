#!/bin/bash
#FLUX: --job-name=dask-cuda-bench
#FLUX: -c=16
#FLUX: --urgency=16

export RUNDIR_HOST='$(readlink -f $(pwd))'
export OUTDIR_HOST='$(readlink -f $(pwd)/outputs/${DATE})'
export SCRATCHDIR_HOST='$(readlink -f $(pwd)/scratch)'
export RUNDIR='/root/rundir'
export OUTDIR='/root/outdir'
export SCRATCHDIR='/root/scratchdir'
export JOB_SCRIPT='${RUNDIR}/job.sh'

DATE=$(date +%Y%m%d)
export RUNDIR_HOST=$(readlink -f $(pwd))
export OUTDIR_HOST=$(readlink -f $(pwd)/outputs/${DATE})
export SCRATCHDIR_HOST=$(readlink -f $(pwd)/scratch)
mkdir -p ${OUTDIR_HOST}
mkdir -p ${SCRATCHDIR_HOST}
export RUNDIR=/root/rundir
export OUTDIR=/root/outdir
export SCRATCHDIR=/root/scratchdir
export JOB_SCRIPT=${RUNDIR}/job.sh
for ucx_version in v1.12.x v1.13.x v1.14.x master; do
    if [ $ucx_version == "v1.13.x" -a $SLURM_JOB_NUM_NODES -ge 4 ]; then
        continue
    fi
    export CONTAINER=$(readlink -f ~/workdir/enroot-images/ucx-py-${ucx_version}-${DATE}.sqsh)
    echo "************************"
    echo "Running ${CONTAINER}"
    echo "***********************"
    srun --container-image=${CONTAINER} --no-container-mount-home \
         --container-mounts=${RUNDIR_HOST}:${RUNDIR}:ro,${OUTDIR_HOST}:${OUTDIR}:rw,${SCRATCHDIR_HOST}:${SCRATCHDIR}:rw \
         ${JOB_SCRIPT}
done
NNODES=$(printf "%02d" $SLURM_JOB_NUM_NODES)
for file in slurm-$SLURM_JOB_NAME-$SLURM_JOB_ID*; do
    mv $file ${OUTDIR_HOST}/${file/-$SLURM_JOB_ID/-$NNODES}
done
