#!/bin/bash
#SBATCH --job-name=gnn_wb
#SBATCH --output=log/TAG_Benchmark_%j.output
#SBATCH --error=error/TAG_Benchmark_%j.error
#SBATCH --mail-user=cc7738@kit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=152
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=501600mb
#SBATCH --time=2-00:00:00
#SBATCH --chdir=/hkfs/work/workspace/scratch/cc7738-benchmark_tag/TAPE_chen/batch

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
