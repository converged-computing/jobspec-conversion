#!/bin/bash
#SBATCH --job-name=bench_insitu
#SBATCH --account=wuc@a100
#SBATCH --output=%x_%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1,a100

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export OMP_PLACES='cores'
export LD_LIBRARY_PATH='/gpfslocalsup/pub/anaconda-py3/2023.09/envs/python-3.11.5/lib:$LD_LIBRARY_PATH'

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BASE_DIR=${WORK}/numpex/bench-in-situ
WORKING_DIR=${BASE_DIR}/working_dir
SCHEFILE=scheduler.json
PREFIX=bench_insitu
DASK_WORKER_NODES=1
SIM_NODES=$(($SLURM_NNODES-2-$DASK_WORKER_NODES))
SIM_PROC=$SIM_NODES
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_PLACES=cores
echo "SLURM_NNODES=$SLURM_NNODES"
echo "OMP_NUM_THREADS=$OMP_NUM_THREADS"
echo "SIM_NODES=$SIM_NODES"
source ${BASE_DIR}/envs/jeanzay/modules.env
cd ${WORKING_DIR}
source deisa/bin/activate
source pdi/share/pdi/env.sh
export LD_LIBRARY_PATH="/gpfslocalsup/pub/anaconda-py3/2023.09/envs/python-3.11.5/lib:$LD_LIBRARY_PATH"
srun -N 1 -n 1 -c 1 -r 0 dask scheduler --protocol tcp --scheduler-file=${SCHEFILE} >> ${PREFIX}_dask-scheduler.o &
while ! [ -f ${SCHEFILE} ]; do
  sleep 3
done
srun -N ${DASK_WORKER_NODES} -n ${DASK_WORKER_NODES} -c 1 -r 1 dask worker --protocol tcp --local-directory /tmp --scheduler-file=${SCHEFILE} >> ${PREFIX}_dask-worker.o &
srun -N 1 -n 1 -c 1 -r $(($DASK_WORKER_NODES+1)) python -O in-situ/fft_updated.py >> ${PREFIX}_client.o &
client_pid=$!
srun -N ${SIM_NODES} -n ${SIM_PROC} -r $(($DASK_WORKER_NODES+2)) build/main ${BASE_DIR}/envs/jeanzay/setup.ini ${BASE_DIR}/envs/jeanzay/io_deisa.yml --kokkos-map-device-id-by=mpi_rank &
simu_pid=$!
wait $simu_pid
