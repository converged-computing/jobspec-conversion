#!/bin/bash
#FLUX: --job-name=DFFT
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --exclusive
#FLUX: --queue=astro-cpu
#FLUX: -t=0
#FLUX: --priority=16

export DASK_CONFIG='${dask_config_path}'
export PYTHONPATH='${project_path}:$PYTHONPATH'
export DASK_SCHEDULER='${protool}://${scheduler}:${dask_port}'

! Dask job script for AstroLab cluster
project_path=${HOME}/work/ska-sdp-distributed-fourier-transform
dask_config_path=${HOME}/work/slurm-scripts/dask_config_distrim_hight_split_mini.yaml
env_name=rascil_new
slurm_worker_log_path=${HOME}/work/slurm-scripts/slurm_out/worker_log
dask_port=9900
dask_dashboardport=9901
source ${HOME}/.bashrc
export DASK_CONFIG=${dask_config_path}
export PYTHONPATH=${project_path}:$PYTHONPATH
cd ${project_path}
echo ${SLURM_JOB_NODELIST}
localdir=/mnt/dask_tmp/$USER
srun mkdir -p ${localdir}
protool=tcp
scheduler=$(ip addr show ib0 | grep inet | grep -v inet6 | awk '{print $2}' | cut -c -12)
dask-scheduler --dashboard-address $dask_dashboardport --protocol ${protool} --interface ib0 --port $dask_port &
sleep 5
srun -o ${slurm_worker_log_path}/srun_%x_%j_worker_%n.out dask-worker --nprocs 3 --nthreads 1 --interface ib0 --memory-limit 320GiB --local-directory ${localdir} ${protool}://${scheduler}:${dask_port} &
sleep 5
echo "[main]project path : ${project_path}"
echo -e "[main]Running python: `which python`"
echo -e "[main]which main in node: `hostname`"
echo -e "[main]Running dask-scheduler: `which dask-scheduler`"
echo "[main]dask-scheduler started on ${protool}://${scheduler}:${dask_port},dashboard: http://${scheduler}:${dask_dashboardport}"
echo -e "[main]Changed directory to `pwd`.\n"
export DASK_SCHEDULER=${protool}://${scheduler}:${dask_port}
python scripts/demo_api.py --swift_config 4k[1]-n2k-512 --queue_size 300 --lru_forward 3 --lru_backward 4
