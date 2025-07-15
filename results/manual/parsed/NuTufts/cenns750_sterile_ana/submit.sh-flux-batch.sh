#!/bin/bash
#FLUX: --job-name=sterilenu
#FLUX: -t=600
#FLUX: --priority=16

CONTAINER=/cluster/tufts/wongjiradlab/twongj01/coherent/coherent_snowglobes_20200304.simg
WORKDIR=/cluster/tufts/wongjiradlab/twongj01/coherent/run_cenns750_sterile_jobs
OUTDIR=${WORKDIR}/grid_output
PARAM_LIST=${WORKDIR}/param_file_dm2_Ue4sq.dat
mkdir -p $OUTDIR
module load singularity
singularity exec $CONTAINER bash -c "cd $WORKDIR && source run_job.sh $PARAM_LIST $OUTDIR $WORKDIR"
