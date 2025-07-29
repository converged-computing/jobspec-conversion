#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=lade
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:0
#SBATCH --mem=120G
#SBATCH --time=04:00:00
#SBATCH --partition=DGX
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='32'
export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

source /u/area/ddoimo/anaconda3/bin/activate ./env_amd
export OMP_NUM_THREADS=32
export PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True"
python diego/analysis/repr_analysis.py \
    --model_name "llama-3-8b" \
    --results_path "diego/analysis/results" \
    --mask_dir /orfeo/cephfs/scratch/area/ddoimo/open/geometric_lens/repo/diego/analysis \
    --epochs 4 \
    --samples_subject 200 \
    --eval_dataset "test" \
    --pretrained_mode "random_order" 
    #--finetuned_mode "dev_val_balanced_20samples" \
    #--pretrained_mode "random_order"
    #--finetuned_mode "test_balanced" \
    #--finetuned_mode "dev_val_balanced_20samples" \
