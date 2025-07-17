#!/bin/bash
#FLUX: --job-name=Singularity_Jupyter_parallel_cuda
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export VENV='$HOME/.envs/venv_cuda_${ULHPC_CLUSTER}'
export JUPYTER_CONFIG_DIR='$HOME/jupyter_sing/$SLURM_JOBID/'
export JUPYTER_PATH='$VENV/share/jupyter":"$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path'
export JUPYTER_DATA_DIR='$HOME/jupyter_sing/$SLURM_JOBID/jupyter_data'
export JUPYTER_RUNTIME_DIR='$HOME/jupyter_sing/$SLURM_JOBID/jupyter_runtime'
export IPYTHONDIR='$HOME/ipython_sing/$SLURM_JOBID'
export IP_ADDRESS='$(hostname -I | awk '{print $1}')'
export XDG_RUNTIME_DIR=''

module load tools/Singularity
export VENV="$HOME/.envs/venv_cuda_${ULHPC_CLUSTER}"
export JUPYTER_CONFIG_DIR="$HOME/jupyter_sing/$SLURM_JOBID/"
export JUPYTER_PATH="$VENV/share/jupyter":"$HOME/jupyter_sing/$SLURM_JOBID/jupyter_path"
export JUPYTER_DATA_DIR="$HOME/jupyter_sing/$SLURM_JOBID/jupyter_data"
export JUPYTER_RUNTIME_DIR="$HOME/jupyter_sing/$SLURM_JOBID/jupyter_runtime"
export IPYTHONDIR="$HOME/ipython_sing/$SLURM_JOBID"
mkdir -p $JUPYTER_CONFIG_DIR
mkdir -p $IPYTHONDIR
export IP_ADDRESS=$(hostname -I | awk '{print $1}')
export XDG_RUNTIME_DIR=""
profile=job_${SLURM_JOB_ID}
echo "On your laptop: ssh -p 8022 -NL 8889:${IP_ADDRESS}:8889 ${USER}@access-${ULHPC_CLUSTER}.uni.lu " 
if [ ! -d "$VENV" ];then
    # For some reasons, there is an issue with venv -- using virtualenv instead
    singularity exec --nv jupyter_parallel_cuda.sif python3 -m virtualenv $VENV --system-site-packages
    singularity run --nv jupyter_parallel_cuda.sif $VENV "python3 -m pip install --upgrade pip" 
    # singularity run --nv jupyter_parallel.sif $VENV "python3 -m pip install <your_packages>"
    singularity run --nv jupyter_parallel_cuda.sif $VENV "python3 -m ipykernel install --sys-prefix --name HPC_SCHOOL_ENV_CUDA --display-name HPC_SCHOOL_ENV_CUDA"
fi
singularity run --nv jupyter_parallel_cuda.sif $VENV "ipython profile create --parallel ${profile}"
singularity run --nv jupyter_parallel_cuda.sif $VENV "jupyter nbextension enable --py ipyparallel"
singularity run --nv jupyter_parallel_cuda.sif $VENV "jupyter notebook --ip ${IP_ADDRESS} --no-browser --port 8889" &
sleep 5s
singularity run --nv jupyter_parallel_cuda.sif $VENV "jupyter notebook list"
singularity run --nv jupyter_parallel_cuda.sif $VENV "jupyter --paths"
singularity run --nv jupyter_parallel_cuda.sif $VENV "jupyter kernelspec list"
wait
