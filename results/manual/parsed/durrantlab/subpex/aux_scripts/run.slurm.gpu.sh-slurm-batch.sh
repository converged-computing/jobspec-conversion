#!/bin/bash
#SBATCH --job-name=subpex_1
#SBATCH --output=job_logs/slurm.out
#SBATCH --error=job_logs/slurm.err
#SBATCH --mail-user=user@email.domain
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=titanx
#SBATCH --constraint=ntasks-per-node=3

source env.sh
SERVER_INFO=$WEST_SIM_ROOT/west_zmq_info-$SLURM_JOBID.json
echo $WEST_PYTHON
w_run --work-manager=serial &> ./job_logs/west-$SLURM_JOBID.log
scontrol show hostname $SLURM_NODELIST > slurm_nodelist.txt
