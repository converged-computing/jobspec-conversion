#!/bin/bash
#FLUX: --job-name=quiv-pub
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --queue=gypsum-m40
#FLUX: -t=1800
#FLUX: --urgency=16

cd /work/sbajaj_umass_edu/GNN_minibatch_vs_fullbatch/pytorch_geometric/torch-quiver
source /work/sbajaj_umass_edu/pygenv1/bin/activate
module load cuda/11.8.0
module load gcc/11.2.0
module load uri/main
module load NCCL/2.12.12-GCCcore-11.3.0-CUDA-11.7.0
QUIVER_ENABLE_CUDA=1 python setup.py install
python3 examples/multi_gpu/pyg/pubmed/dist_sampling_ogb_pubmed_quiver.py
