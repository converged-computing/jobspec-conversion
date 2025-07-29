#!/bin/bash
#SBATCH --output=34b_replication_%j.out
#SBATCH --error=34b_replication_%j.out
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export DLTS_HOSTFILE='path/to/hostfile/hosts_$SLURM_JOBID'

source /path/to/conda_setup_script.sh
ds_report
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
TRAIN_PATH=/path/to/gpt-neox
cd $TRAIN_PATH
bash /helper/script/write_hostfile.sh
export DLTS_HOSTFILE=path/to/hostfile/hosts_$SLURM_JOBID
python $TRAIN_PATH/deepy.py $TRAIN_PATH/train.py \
        --conf_dir /path/to/math-lm/pretraining llemma_34b.yml data_mixture.yml   
