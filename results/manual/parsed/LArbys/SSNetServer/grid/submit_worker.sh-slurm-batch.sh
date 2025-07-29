#!/bin/bash
#SBATCH --job-name=ssn_workers
#SBATCH --output=ssn_workers.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4000
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH --array=0-3
#SBATCH --nodelist=pgpu03

CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-ssnetserver/singularity-ssnetserver-caffelarbys-cuda8.0.img
WORKDIR=/usr/local/ssnetserver
BROKER=10.246.81.73 # PGPU03
PORT=5560
GPU_ASSIGNMENTS=${WORKDIR}/grid/gpu_assignments.txt
module load singularity
singularity exec --nv ${CONTAINER} bash -c "cd ${WORKDIR}/grid && ./run_caffe1worker.sh ${WORKDIR} ${BROKER} ${PORT} ${GPU_ASSIGNMENTS}"
