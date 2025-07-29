#!/bin/bash
#FLUX: --job-name=quiv-red
#FLUX: -c=56
#FLUX: --queue=gpu-preempt
#FLUX: -t=1500
#FLUX: --urgency=16

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
  echo "reddit quiver"
  echo $n_parts
    python3 examples/multi_gpu/pyg/reddit/dist_sampling_ogb_reddit_quiver.py \
    --n-epochs 5 \
    --model graphsage \
    --n-gpus $n_parts \
    --n_layers 2 \
    --n_hidden 1024 \
    --fanout 20 \
    --heads 4 \
    --batch_size 1024 \
    --log_every 10
done
