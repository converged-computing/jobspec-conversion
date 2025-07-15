#!/bin/bash
#FLUX: --job-name=jupyter-lab
#FLUX: -c=4
#FLUX: -t=10800
#FLUX: --priority=16

export DASK_DISTRIBUTED__DASHBOARD__LINK='proxy/{port}/status'

mkdir -p ./logs
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
cluster="stokes"
module purge
module load anaconda/anaconda3
source ~/.bashrc
conda activate dask-tutorial
export DASK_DISTRIBUTED__DASHBOARD__LINK="proxy/{port}/status"
echo -e "
For MacOS, Linux, or native Windows SSH create your ssh tunnel with the following command
ssh -N -L ${port}:${node}:${port} ${user}@${cluster}.ist.ucf.edu
Windows MobaXterm info
Forwarded port:same as remote port
Remote server: ${node}
Remote port: ${port}
SSH server: ${cluster}.ist.ucf.edu
SSH login: $user
SSH port: 22
Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"
jupyter lab --no-browser --port=${port} --ip=${node}
