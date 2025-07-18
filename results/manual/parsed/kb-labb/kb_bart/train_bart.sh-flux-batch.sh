#!/bin/bash
#FLUX: --job-name=kb_bart
#FLUX: -N=16
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

export MASTER_ADDR='`/bin/hostname -s`'
export MASTER_PORT='13673'
export NPROC_PER_NODE='4'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export MASTER_ADDR=`/bin/hostname -s`
export MASTER_PORT=13673
export NPROC_PER_NODE=4
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
DATETIME=`date +'date_%y-%m-%d_time_%H-%M-%S'`
PROJECT=/ceph/hpc/home/eufatonr/faton/kb_bart
LOGGING=$PROJECT/logs
LOGFILE="${LOGGING}/%x_${DATETIME}.log"
echo $LOGFILE
echo $MASTER_ADDR
echo $MASTER_PORT
echo $NPROC_PER_NODE
echo $SLURM_JOB_NAME
echo $SLURM_JOB_ID
echo $SLURM_JOB_NODELIST
echo $SLURM_JOB_NUM_NODES
echo $SLURM_LOCALID
echo $SLURM_NODEID
echo $SLURM_PROCID
train_cycle=`cat current_cycle.txt`
DATA_DIRS=""
data_dirs_added=$(ls -d -1 "data/"**/ | shuf | tr "\n" ":")
for i in `seq $train_cycle`
do  
    DATA_DIRS=${DATA_DIRS}${data_dirs_added}
done
export DATA_DIRS
echo $DATA_DIRS
echo "$((train_cycle + 1))" > current_cycle.txt
echo "${DATA_DIRS}" > current_shards.txt
run_cmd="bash train_bart_args.sh"
ls -ltrh
pwd
srun -l -o $LOGFILE singularity exec --nv -B $(pwd) pytorch_21.03_bart.sif ${run_cmd}
