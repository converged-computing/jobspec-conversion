#!/bin/bash
#FLUX: --job-name=quiv-ork
#FLUX: -c=56
#FLUX: --queue=gpu-preempt
#FLUX: -t=1500
#FLUX: --urgency=16

nvidia-smi --query-gpu=gpu_name --format=csv,noheader
nvidia-smi topo -m
echo "SLURM_GPUS="$SLURM_GPUS
echo "SLURM_NODELIST = "$SLURM_NODELIST
echo "SLURM_MEM_PER_NODE = "$SLURM_MEM_PER_NODE "MB"
echo "SLURM_JOB_PARTITION = "$SLURM_JOB_PARTITION
cd /work/sbajaj_umass_edu/GNN_minibatch_vs_fullbatch/pytorch_geometric/torch-quiver
source /work/sbajaj_umass_edu/pygenv1/bin/activate
module load cuda/11.8.0
module load gcc/11.2.0
module load uri/main
module load NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
echo "nvlink experiment"
QUIVER_ENABLE_CUDA=1 python setup.py install
for n_parts in 1 2 3 4
do
  echo "using "$n_parts" GPUS"
  python3 examples/multi_gpu/pyg/orkut/dist_sampling_orkut_quiver.py \
    --model gat \
    --n-epochs 5 \
    --n-gpus $n_parts \
    --n-layers 3 \
    --n-hidden 128 \
    --batch-size 1024 \
    --eval-batch-size 100000 \
    --weight-decay 0 \
    --fanout 5 \
    --heads 2 \
    --agg mean \
    --log-every 10
done
