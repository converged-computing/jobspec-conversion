#!/bin/bash
#FLUX: --job-name=sticky-salad-6473
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=gaia
#FLUX: --urgency=16

export NCCL_DEBUG='WARN'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'

set -o nounset
export NCCL_DEBUG=WARN
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME=^docker0,lo
function set_master_addr_and_port () {
    JOB_NODELIST=SLURM_JOB_NODELIST
    HOSTNAMES=$(scontrol show hostnames ${!JOB_NODELIST})
    MASTER_ADDR=$(echo ${HOSTNAMES} | tr " " "\n" | head -n 1)
    REST_ADDRS=$(echo ${HOSTNAMES} | tr " " "\n" | tail -n +2)
    REST_ADDRS=$(echo ${REST_ADDRS} | tr " " ",")
    MASTER_PORT=$(srun --nodes=1 --ntasks=1 --exclude=${REST_ADDRS} python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
    export MASTER_ADDR=${MASTER_ADDR}
    export MASTER_PORT=${MASTER_PORT}
    echo MASTER_ADDR=$MASTER_ADDR
    echo MASTER_PORT=$MASTER_PORT
}
set_master_addr_and_port
echo "Other options: $@"
srun python -u train.py $@
echo "Job finished $(date)"
exit 0
