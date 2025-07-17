#!/bin/bash
#FLUX: --job-name=demo
#FLUX: --queue=workq
#FLUX: -t=1800
#FLUX: --urgency=16

export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'
export XDG_RUNTIME_DIR='/tmp node=$(hostname -s) '

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
module swap PrgEnv-cray PrgEnv-intel
module load intelpython3/2022.0.2.155 pytorch/1.8.0
export XDG_RUNTIME_DIR=/tmp node=$(hostname -s) 
user=$(whoami) 
submit_host=${SLURM_SUBMIT_HOST} 
gateway=${EPROXY_LOGIN}
port=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo ${node} pinned to port ${port} on ${gateway} 
echo -e "
To connect to the compute node ${node} on Shaheen running your jupyter notebook server,
you need to run following two commands in a terminal
1. Command to create ssh tunnel from you workstation/laptop to cdlX:
ssh -L ${port}:localhost:${port} ${user}@${submit_host}.hpc.kaust.edu.sa
2. Command to create ssh tunnel to run on cdlX:
ssh -L ${port}:${node}:${port} ${user}@${gateway}
Copy the link provided below by jupyter-server and replace the nid0XXXX with localhost before pasting it in your browser on your workstation/laptop. Do not forget to close the notebooks you open in you browser and shutdown the jupyter client in your browser for gracefully exiting this job or else you will have to mannually cancel this job running your jupyter server.
"
echo "Starting jupyter server in background with requested resouce"
jupyter ${1:-lab} --no-browser --port=${port} --port-retries=0  --ip=${node}
