#!/bin/bash
#FLUX: --job-name=gnn_wb
#FLUX: -n=152
#FLUX: --queue=accelerated
#FLUX: -t=172800
#FLUX: --urgency=16

source /hkfs/home/project/hk-project-test-p0021478/cc7738/anaconda3/etc/profile.d/conda.sh
conda activate base
conda activate EAsF
module purge
module load devel/cmake/3.18
module load devel/cuda/11.8
module load compiler/gnu/12
cd /hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE_chen/core/gcns
device_list=(0 1 2 3)
data_list=(pubmed)  #pubmed arxiv_2023
model_list=(GAT_Variant)
cd TAPE_chen/core/gcns/
python final_gnn_tune.py --data cora --device cuda:0 --epochs 1000 --model GAT_Variant --wandb 
cd TAPE_chen/core/gcns/
python final_gnn_tune.py --data pubmed --device cuda:1 --epochs 1000 --model GAT_Variant --wandb 
cd TAPE_chen/core/gcns/
python final_gnn_tune.py --data arxiv_2023 --device cuda:2 --epochs 1000 --model GAT_Variant --wandb 
