#!/bin/bash
#SBATCH --account=m4055_g
#SBATCH --nodes=1
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=regular
#SBATCH --constraint=gpu,ntasks-per-node=4

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
