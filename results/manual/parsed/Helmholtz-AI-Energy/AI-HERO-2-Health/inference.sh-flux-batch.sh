#!/bin/bash
#FLUX: --job-name=AI-HERO_health_baseline_inference
#FLUX: -c=152
#FLUX: --queue=accelerated
#FLUX: -t=72000
#FLUX: --urgency=16

export CUDA_CACHE_DISABLE='1'
export OMP_NUM_THREADS='1'

export CUDA_CACHE_DISABLE=1
export OMP_NUM_THREADS=1
group_workspace=/home/hk-project-test-aihero2/hgf_pdv3669
source ${group_workspace}/health_baseline_env/bin/activate
python ${group_workspace}/ai-hero2/inference.py --from_checkpoint ./lightning_logs/version_3/checkpoints/epoch=99-step=10000.ckpt --pred_dir ./pred
