#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=32
#FLUX: --queue=DGX
#FLUX: -t=14400
#FLUX: --priority=16

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
