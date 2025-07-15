#!/bin/bash
#FLUX: --job-name=angry-bits-4669
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=wrfc6gn
#FLUX: --urgency=16

export WRF_VERSION='3.9.1'
export JOB_DIR='/fsx/spooler/run'

export WRF_VERSION=3.9.1
export JOB_DIR=/fsx/spooler/run
source /fsx/scripts/env.sh 0 0
ulimit -s unlimited
if [ "${HPC_MPI}" == "intelmpi" ]
then
    SHOW_BIND_OPTS="-print-rank-map"
elif ["${HPC_MPI}" == "openmpi" ]
then
    SHOW_BIND_OPTS="--report-bindings"
fi
echo "Running WRF on $(date)"
cd ${JOB_DIR}
ln -sf /fsx/wrf-${WARCH}/${WRF_COMPILER}/${HPC_MPI}/WRF-${WRF_VERSION}/main/wrf.exe  .
echo "$(date +"%Y%m%d-%H:%M:%S")[$(date "+%s"]: StartJob - $(basename ${JOB_DIR}) - ${WRF_COMPILER} - ${HPC_MPI}" >> wrf_$(arch).times
mpirun --mca pml cm --mca mtl ofi --mca pml_base_verbose 10 --mca mtl_base_verbose 10 ./wrf.exe >> mpirun_${WARCH}_${WRF_COMPILER}_${HPC_MPI}_debug.log 2>&1
echo nstasks=$SLURM_NTASKS
echo "$(date +"%Y%m%d-%H:%M:%S"): JobEnd - $(basename ${JOB_DIR}) - ${WRF_COMPILER} - ${HPC_MPI}" >> wrf_$(arch).times
