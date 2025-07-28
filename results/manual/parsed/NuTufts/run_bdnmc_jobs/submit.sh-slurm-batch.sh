#!/bin/bash
#FLUX: --job-name=bdnmc
#FLUX: -t=86400
#FLUX: --urgency=16

CONTAINER=/cluster/tufts/wongjiradlab/twongj01/coherent/coherent_bdnmc_20200302.simg
WORKDIR=/cluster/tufts/wongjiradlab/twongj01/coherent/run_bdnmc_jobs
OUTDIR=${WORKDIR}/grid_output
PARAM_LIST=$WORKDIR/params.list
mkdir -p $OUTDIR
module load singularity
singularity exec $CONTAINER bash -c "cd $WORKDIR && source run_job.sh $PARAM_LIST $OUTDIR $WORKDIR"
