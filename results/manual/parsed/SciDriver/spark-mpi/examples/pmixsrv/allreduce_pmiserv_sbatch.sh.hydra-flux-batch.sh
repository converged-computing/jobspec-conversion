#!/bin/bash
#FLUX: --job-name=misunderstood-pastry-7939
#FLUX: -N=4
#FLUX: --queue=[partition]
#FLUX: --priority=16

export HYDRA_PROXY_PORT='55555'

module load spark-mpi/0.1                                                                          
scontrol show hostname $SLURM_JOB_NODELIST | paste -d'\n' -s > hosts
export HYDRA_PROXY_PORT=55555
pmiserv -f hosts hello &
srun ./allreduce.slurm.py
srun pkill "hydra_pmi_proxy"
