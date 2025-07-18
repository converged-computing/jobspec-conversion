#!/bin/bash
#FLUX: --job-name=bumfuzzled-snack-9578
#FLUX: -N=4
#FLUX: -n=128
#FLUX: --queue=workq
#FLUX: -t=7200
#FLUX: --urgency=16

export XDG_RUNTIME_DIR=''
export LC_ALL='C.UTF-8'
export LANG='C.UTF-8'

module swap PrgEnv-cray PrgEnv-gnu
module load dask/2.22.0
module load jupyter/1.0.0
export XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
direct=$(pwd)
gateway=${EPROXY_LOGIN}
submit_host=${SLURM_SUBMIT_HOST}
port=8889
dask_dashboard=10001
echo working on $direct 
echo $node on $gateway pinned to port $port
echo -e "
To connect to the compute node ${node} on Shaheen running your jupyter notebook server,
you need to run following two commands in a terminal
1. Command to create ssh tunnel from you workstation/laptop to cdlX:
ssh -L ${port}:localhost:${port} -L ${dask_dashboard}:localhost:${dask_dashboard} ${user}@${submit_host}.hpc.kaust.edu.sa
2. Command to create ssh tunnel to run on cdlX:
ssh -L ${port}:${node}:${port} -L ${dask_dashboard}:${node}:${dask_dashboard} ${user}@${gateway}
Copy the link provided below by jupyter-server and replace the nid0XXXX with localhost before pasting it in your browser on your workstation/laptop. Do not forget to close the notebooks you open in you browser and shutdown the jupter client in your browser for gracefully exiting this job or else you will have to mannually cancel this job running your jupyter server.
"
echo "Starting dask server in background with requested resouce"
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
srun --hint=nomultithread -n ${SLURM_NTASKS} -c ${SLURM_CPUS_PER_TASK} -N ${SLURM_NNODES} dask-mpi --no-nanny --nthreads=${SLURM_CPUS_PER_TASK}  --memory-limit="4GB" --local-directory=workers${SLURM_JOBID} --scheduler-file=scheduler_${SLURM_JOBID}.json --interface=ipogif0 --scheduler-port=6192 --dashboard-address=${node}:${dask_dashboard} &
jupyter notebook --no-browser --port=${port} --ip=${node}
