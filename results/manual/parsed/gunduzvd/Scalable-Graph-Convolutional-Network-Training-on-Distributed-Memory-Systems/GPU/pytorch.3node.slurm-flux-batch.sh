#!/bin/bash
#FLUX: --job-name=3node
#FLUX: -N=3
#FLUX: -c=42
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$master_addr'

print_usage() {
  echo "Usage: -d <dataset> -l <num_layers> -f <num_features> -p <partitioning>"
}
while getopts 'd:l:f:p:' flag; do
  case "${flag}" in
    d) dataset=${OPTARG} ;;
    l) layers=${OPTARG} ;;
    f) features=${OPTARG} ;;
    p) partitioning=${OPTARG} ;;
    *) print_usage
       exit 1 ;;
  esac
done
module purge
module load GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
module load PyTorch/1.9.0
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Dataset:= " ${dataset}
echo "Number of layers:= " ${layers}
echo "Number of features:= " ${features}
echo "Partitioning:= " ${partitioning}
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "MASTER_PORT"=$MASTER_PORT
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
srun python ../PGCN.py \
-a /home/a/ahaldar/dev/data-mtx/${dataset}/${dataset}.A.mtx \
-p /home/a/ahaldar/dev/data-parts/${dataset}.A.mtx.${WORLD_SIZE}.${partitioning} \
-b nccl \
-l ${layers} \
-f ${features} #\
