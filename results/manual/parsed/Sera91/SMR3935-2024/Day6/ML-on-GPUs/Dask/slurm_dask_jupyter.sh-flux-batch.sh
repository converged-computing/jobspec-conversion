#!/bin/bash
#FLUX: --job-name=loopy-punk-4417
#FLUX: --priority=16

export VENV='$HOME/.envs/jupyter_dask_${ULHPC_CLUSTER}'
export JUPYTER_CONFIG_DIR='$HOME/jupyter/$SLURM_JOBID/'
export JUPYTER_PATH='$VENV/share/jupyter":"$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path'
export JUPYTER_DATA_DIR='$HOME/jupyter/$SLURM_JOBID/jupyter_data'
export JUPYTER_RUNTIME_DIR='$HOME/jupyter/$SLURM_JOBID/jupyter_runtime'
export IP_ADDRESS='$(hostname -I | awk '{print $1}')'
export DASK_CONFIG='${HOME}/.dask'
export DASK_JOB_CONFIG='${DASK_CONFIG}/job_${SLURM_JOB_ID}'
export SCHEDULER_FILE='${DASK_JOB_CONFIG}/scheduler.json'
export XDG_RUNTIME_DIR=''
export NB_WORKERS='$((${SLURM_NTASKS}-2))'

module load lang/Python
export VENV="$HOME/.envs/jupyter_dask_${ULHPC_CLUSTER}"
export JUPYTER_CONFIG_DIR="$HOME/jupyter/$SLURM_JOBID/"
export JUPYTER_PATH="$VENV/share/jupyter":"$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path"
export JUPYTER_DATA_DIR="$HOME/jupyter/$SLURM_JOBID/jupyter_data"
export JUPYTER_RUNTIME_DIR="$HOME/jupyter/$SLURM_JOBID/jupyter_runtime"
mkdir -p $JUPYTER_CONFIG_DIR
export IP_ADDRESS=$(hostname -I | awk '{print $1}')
export DASK_CONFIG="${HOME}/.dask"
export DASK_JOB_CONFIG="${DASK_CONFIG}/job_${SLURM_JOB_ID}"
mkdir -p ${DASK_JOB_CONFIG}
export SCHEDULER_FILE="${DASK_JOB_CONFIG}/scheduler.json"
if [ ! -d "$VENV" ];then
    echo "Building the virtual environment"
    # Create the virtualenv
    python3 -m venv $VENV 
    # Load the virtualenv
    source "$VENV/bin/activate"
    # Upgrade pip 
    python3 -m pip install pip --upgrade
    # Install minimum requirement
    python3 -m pip install dask[complete] matplotlib \
        dask-jobqueue \
        graphviz \
        xgboost \
        jupyter \
        jupyter-server-proxy
    # Setup ipykernel
    # "--sys-prefix" install ipykernel where python is installed
    # here next the python symlink inside the virtualenv
    python3 -m ipykernel install --sys-prefix --name custom_kernel --display-name custom_kernel
fi
export XDG_RUNTIME_DIR=""
source "${VENV}/bin/activate"
echo "On your laptop: ssh -p 8022 -NL 8889:${IP_ADDRESS}:8889 ${USER}@access-${ULHPC_CLUSTER}.uni.lu " 
srun --exclusive -N 1 -n 1 -c 1 -w $(hostname) jupyter notebook --ip ${IP_ADDRESS} --no-browser --port 8889 &
sleep 5s
srun --exclusive -N 1 -n 1 -c 1 -w $(hostname) jupyter notebook list
srun --exclusive -N 1 -n 1 -c 1 -w $(hostname) jupyter --paths
srun --exclusive -N 1 -n 1 -c 1 -w $(hostname) jupyter kernelspec list
srun -w $(hostname) --exclusive -N 1 -n 1 -c 1 \
     dask-scheduler  --scheduler-file "${SCHEDULER_FILE}"  --interface "ib0" &
sleep 10
export NB_WORKERS=$((${SLURM_NTASKS}-2))
srun  --exclusive -n ${NB_WORKERS} -c 1 \
     --cpu-bind=cores dask-worker  \
     --label \
     --interface "ib0" \
     --scheduler-file "${SCHEDULER_FILE}"  &
wait
