#!/bin/bash
#FLUX: --job-name=ssn_workers
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-ssnetserver/singularity-ssnetserver-caffelarbys-cuda8.0.img
WORKDIR=/usr/local/ssnetserver
BROKER=10.246.81.73 # PGPU03
PORT=5560
GPU_ASSIGNMENTS=${WORKDIR}/grid/gpu_assignments.txt
module load singularity
singularity exec --nv ${CONTAINER} bash -c "cd ${WORKDIR}/grid && ./run_caffe1worker.sh ${WORKDIR} ${BROKER} ${PORT} ${GPU_ASSIGNMENTS}"
