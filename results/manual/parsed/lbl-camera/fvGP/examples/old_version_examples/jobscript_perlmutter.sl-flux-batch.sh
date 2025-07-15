#!/bin/bash
#FLUX: --job-name=angry-fudge-9196
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'
export OMP_NUM_THREADS='8'

export SLURM_CPU_BIND="cores"
number_of_workers=256
source /global/homes/m/mcn/gp2Scale/gp2Scale_env/bin/activate
export OMP_NUM_THREADS=8
echo We have nodes: ${SLURM_JOB_NODELIST}
echo "$SDN_IP_ADDR"
hn=$(hostname -s)
port="8786"
echo ${port}
echo "starting scheduler"
dask-scheduler --no-dashboard --no-bokeh --no-show --host ${hn} --port ${port} &
echo "starting workers"
srun -o dask_worker_info.txt dask-worker ${hn}:${port} &
echo "starting gp2Scale"
python -u run_GPU.py ${hn}:${port} ${number_of_workers}
