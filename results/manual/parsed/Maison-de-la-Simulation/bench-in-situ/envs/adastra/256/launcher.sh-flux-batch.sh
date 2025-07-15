#!/bin/bash
#FLUX: --job-name=bench_insitu
#FLUX: -N=35
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export OMP_PLACES='cores'
export LD_LIBRARY_PATH='/opt/cray/pe/python/3.11.5/lib/:$LD_LIBRARY_PATH'

SIMU_SIZE=256
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BASE_DIR=${HOME}/bench-in-situ
WORKING_DIR=${BASE_DIR}/working_dir
SCHEFILE=scheduler.json
PREFIX=bench_insitu
DASK_WORKER_NODES=1
SIM_NODES=$(($SLURM_NNODES-2-$DASK_WORKER_NODES))
SIM_PROC=8
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_PLACES=cores
echo "SLURM_NNODES=$SLURM_NNODES"
echo "OMP_NUM_THREADS=$OMP_NUM_THREADS"
echo "SIM_NODES=$SIM_NODES"
source ${BASE_DIR}/envs/adastra/modules.env
mkdir -p $SNAPSHOT_FILE_PATH/$SIMU_SIZE
sed -i "s|^prefix=.*|prefix=$SNAPSHOT_FILE_PATH/$SIMU_SIZE/Checkpoint|" ${BASE_DIR}/envs/adastra/${SIMU_SIZE}/setup.ini
cd ${WORKING_DIR}
source deisa/bin/activate
export LD_LIBRARY_PATH=/opt/cray/pe/python/3.11.5/lib/:$LD_LIBRARY_PATH
source pdi/share/pdi/env.sh 
srun -N 1 -n 1 -c 1 -r 0 dask scheduler --scheduler-file=${SCHEFILE} >> ${PREFIX}_dask-scheduler.o &
while ! [ -f ${SCHEFILE} ]; do
  sleep 3
done
srun -N ${DASK_WORKER_NODES} -n ${DASK_WORKER_NODES} -c 1 -r 1 dask worker --local-directory /tmp --scheduler-file=${SCHEFILE} >> ${PREFIX}_dask-worker.o &
srun -N 1 -n 1 -c 1 -r $(($DASK_WORKER_NODES+1)) python -O ${BASE_DIR}/in-situ/fft_updated.py >> ${PREFIX}_client.o &
client_pid=$!
srun -N ${SIM_NODES} -n ${SIM_PROC} -r $(($DASK_WORKER_NODES+2)) build/main ${BASE_DIR}/envs/adastra/${SIMU_SIZE}/setup.ini ${BASE_DIR}/envs/adastra/io_deisa.yml --kokkos-map-device-id-by=mpi_rank &
simu_pid=$!
wait $simu_pid
rm ${SNAPSHOT_FILE_PATH}/${SIMU_SIZE}/*.h5 && rm ${SNAPSHOT_FILE_PATH}/${SIMU_SIZE}/*.xmf
