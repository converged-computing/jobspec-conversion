#!/bin/bash
#FLUX: --job-name=tag_struc2vec
#FLUX: -N=2
#FLUX: -n=20
#FLUX: --queue=accelerated
#FLUX: -t=86400
#FLUX: --priority=16

source /hkfs/home/project/hk-project-test-p0021478/cc7738/anaconda3/etc/profile.d/conda.sh
conda activate base
conda activate nui
cd /hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE/core/gcns
module purge
module load devel/cmake/3.18
module load devel/cuda/11.8
module load compiler/gnu/12
python core/gcns/wb_tune.py --cfg core/yamls/cora/gcns/gae.yaml --sweep core/yamls/cora/gcns/gae_sp1.yaml
