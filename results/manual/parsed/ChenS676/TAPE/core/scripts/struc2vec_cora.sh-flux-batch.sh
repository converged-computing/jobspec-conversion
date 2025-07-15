#!/bin/bash
#FLUX: --job-name=tag_struc2vec
#FLUX: -N=2
#FLUX: -n=20
#FLUX: --queue=cpuonly
#FLUX: -t=345600
#FLUX: --priority=16

source /hkfs/home/project/hk-project-test-p0021478/cc7738/anaconda3/etc/profile.d/conda.sh
conda activate base
conda activate TAG-LP
cd /hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE/core/Embedding
module purge
module load devel/cmake/3.18
module load devel/cuda/11.8
module load compiler/gnu/12
ls -ltr
python wb_tune_struc2vec.py --sweep core/yamls/cora/struc2vec_sp3.yaml --cfg core/yamls/cora/struc2vec.yaml 
