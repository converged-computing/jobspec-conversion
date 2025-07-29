#!/bin/bash
#SBATCH --job-name=prod-quiv
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=56
#SBATCH --gres=4
#SBATCH --mem=100G
#SBATCH --time=00:25:00
#SBATCH --partition=gpu-preempt
#SBATCH --constraint=intel8480

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
source /work/sbajaj_umass_edu/pygenv1/bin/activate
for n_parts in 1 2 3 4
do
  echo "ogbn-products quiver"
  echo $n_parts
  python3 examples/multi_gpu/pyg/ogb-products/dist_sampling_ogb_products_quiver.py \
    --model graphsage \
    --n-epochs 5 \
    --n-gpus $n_parts \
    --n-layers 3 \
    --n-hidden 128 \
    --batch-size 1024 \
    --eval-batch-size 100000 \
    --weight-decay 0 \
    --fanout 20 \
    --heads 3 \
    --agg mean \
    --log-every 10
done
