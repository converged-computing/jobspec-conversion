#!/bin/bash
#FLUX: --job-name=papers-mb
#FLUX: -c=112
#FLUX: --queue=gpu-preempt
#FLUX: -t=7200
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$master_addr'

nvidia-smi --query-gpu=gpu_name --format=csv,noheader
nvidia-smi topo -m
export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "MASTER_PORT="$MASTER_PORT
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
echo "NUM GPUS PER NODE="$SLURM_GPUS 
echo "SLURM_GPUS="$SLURM_GPUS
echo "SLURM_NODELIST = "$SLURM_NODELIST
echo "SLURM_MEM_PER_NODE = "$SLURM_MEM_PER_NODE "MB"
echo "SLURM_JOB_PARTITION = "$SLURM_JOB_PARTITION
echo "Total GPUs ="$(($SLURM_GPUS * $SLURM_NNODES))
source /work/sbajaj_umass_edu/GNNEnv/bin/activate
python main.py \
  --dataset ogbn-papers100M \
  --dataset-subgraph-path /work/sbajaj_umass_edu/GNN_minibatch_vs_fullbatch/DGL/DGL_reference_implementation/subgraph/ogbn-papers100M_frac_100.0_hops_2_subgraph.bin \
  --model garphsage \
  --sampling NS \
  --dropout 0.5 \
  --lr 0.001 \
  --n-epochs 100 \
  --n-gpus 4 \
  --n-layers 2 \
  --n-hidden 128 \
  --batch-size 4096 \
  --fanout 5 \
  --patience 200 \
  --agg mean \
  --log-every 2 \
  --seed 42 \
  # --mode puregpu \
