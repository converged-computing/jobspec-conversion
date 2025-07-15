#!/bin/bash
#FLUX: --job-name=reclusive-onion-9505
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'
export OMP_NUM_THREADS='8'

export SLURM_CPU_BIND="cores"
number_of_workers=32
source /global/homes/m/mcn/gp2Scale/gp2Scale_env/bin/activate
export OMP_NUM_THREADS=8
echo We have nodes: ${SLURM_JOB_NODELIST}
echo "$SDN_IP_ADDR"
hn=$(hostname -s)
port="8786"
echo ${port}
echo "starting scheduler"
dask-scheduler --no-dashboard --no-show --host ${hn} --port ${port} &
echo "starting workers"
srun -o dask_worker_info.txt dask-worker ${hn}:${port} --nthreads 1 &
echo "starting gp2Scale"
python -u gp2Scale_example_HPC_RunScript.py ${hn}:${port} ${number_of_workers}
