#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=[partition]
#SBATCH --constraint=ntasks-per-node=1

export HYDRA_PROXY_PORT='55555'

module load spark-mpi/0.1                                                                          
scontrol show hostname $SLURM_JOB_NODELIST | paste -d'\n' -s > hosts
export HYDRA_PROXY_PORT=55555
pmiserv -f hosts hello &
srun ./allreduce.slurm.py
srun pkill "hydra_pmi_proxy"
