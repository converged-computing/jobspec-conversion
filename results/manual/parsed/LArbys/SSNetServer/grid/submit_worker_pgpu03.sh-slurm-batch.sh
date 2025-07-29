#!/bin/bash
#FLUX: --job-name=ssn_workers_pgpu03
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-ssnetserver/singularity-ssnetserver-caffelarbys-cuda8.0.img
SSS_BASEDIR=/cluster/kappa/wongjiradlab/twongj01/ssnetserver
WORKDIR=/cluster/kappa/wongjiradlab/larbys/pubs/dlleepubs/serverssnet
BROKER=10.246.81.73 # PGPU03
PORT=5560
GPU_ASSIGNMENTS=/cluster/kappa/wongjiradlab/larbys/pubs/dlleepubs/serverssnet/tufts_pgpu03_assignments.txt
module load singularity
singularity exec --nv ${CONTAINER} bash -c "cd ${SSS_BASEDIR}/grid && ./run_caffe1worker.sh ${SSS_BASEDIR} ${WORKDIR} ${BROKER} ${PORT} ${GPU_ASSIGNMENTS}"
