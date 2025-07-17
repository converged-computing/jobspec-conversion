#!/bin/bash
#FLUX: --job-name=cowy-pancake-1394
#FLUX: -c=20
#FLUX: -t=1800
#FLUX: --urgency=16

export DATA_DIR='/ibex/ai/reference/CV/tinyimagenet'
export XDG_RUNTIME_DIR='/tmp node=$(hostname -s) '

source /ibex/ai/home/$USER/miniconda3/bin/activate dist-pytorch
export DATA_DIR=/ibex/ai/reference/CV/tinyimagenet
export XDG_RUNTIME_DIR=/tmp node=$(hostname -s) 
user=$(whoami) 
submit_host=${SLURM_SUBMIT_HOST} 
port=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
tb_port=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo ${node} pinned to port ${port} on ${submit_host} 
echo -e " 
${node} pinned to port ${port} on ${submit_host} 
To connect to the compute node ${node} on IBEX running your jupyter notebook server, you need to run following two commands in a terminal 1. 
Command to create ssh tunnel from you workstation/laptop to glogin: 
ssh -L ${port}:${node}.ibex.kaust.edu.sa:${port} -L ${tb_port}:${node}:${tb_port} ${user}@glogin.ibex.kaust.edu.sa 
Copy the link provided below by jupyter-server and replace the NODENAME with localhost before pasting it in your browser on your workstation/laptop.
" >&2 
tensorboard --logdir $PWD/logs --host ${node} --port ${tb_port} &
jupyter-lab --no-browser --port=${port} --port-retries=0  --ip=${node}.ibex.kaust.edu.sa
