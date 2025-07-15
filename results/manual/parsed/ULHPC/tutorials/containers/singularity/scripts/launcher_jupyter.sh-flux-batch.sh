#!/bin/bash
#FLUX: --job-name=boopy-pancake-4257
#FLUX: -t=3600
#FLUX: --priority=16

export JUPYTER_CONFIG_DIR='$HOME/jupyter_sing/$SLURM_JOBID/'
export JUPYTER_PATH='$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path'
export JUPYTER_DATA_DIR='$HOME/jupyter_sing/$SLURM_JOBID/jupyter_data'
export JUPYTER_RUNTIME_DIR='$HOME/jupyter_sing/$SLURM_JOBID/jupyter_runtime'
export IPYTHONDIR='$HOME/ipython_sing/$SLURM_JOBID'
export IP_ADDRESS='$(hostname -I | awk '{print $1}')'

module load tools/Singularity
export JUPYTER_CONFIG_DIR="$HOME/jupyter_sing/$SLURM_JOBID/"
export JUPYTER_PATH="$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path"
export JUPYTER_DATA_DIR="$HOME/jupyter_sing/$SLURM_JOBID/jupyter_data"
export JUPYTER_RUNTIME_DIR="$HOME/jupyter_sing/$SLURM_JOBID/jupyter_runtime"
export IPYTHONDIR="$HOME/ipython_sing/$SLURM_JOBID"
mkdir -p $IPYTHONDIR
export IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "On your laptop: ssh -p 8022 -NL 8889:${IP_ADDRESS}:8889 ${USER}@access-${ULHPC_CLUSTER}.uni.lu " 
singularity instance start jupyter.sif jupyter
singularity exec instance://jupyter jupyter \
    notebook --ip ${IP_ADDRESS} --no-browser --port 8889 &
pid=$!
sleep 5s
singularity exec instance://jupyter  jupyter notebook list
wait $pid
echo "Stopping instance"
singularity instance stop jupyter
