#!/bin/bash
#FLUX: --job-name=tart-dog-3308
#FLUX: --queue=small
#FLUX: --urgency=16

echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo "Setting up bash enviroment"
module load python/anaconda3
module load gcc
source activate torch
set -e
cd /jmain02/home/J2AD002/jxm12/lxx22-jxm12/model-inference
DEPLOY=( "t5_sst2_S_r2" "t5_sst2_M_r2" "t5_sst2_L_r2" "t5_sst2_XL_r2" )
TAGS=( "ray-S-R2" "ray-M-R2" "ray-L-R2" "ray-XL-R2" )
for i in ${!TAGS[@]}; do
    echo "$i, ${TAGS[$i]}, ${DEPLOY[$i]}"
    bash ray/run_serve.sh ${DEPLOY[$i]}
    sleep 15m
    ${HOME}/.conda/envs/torch/bin/python tests/test_cost_model.py --dataset_name glue --task_name sst2 --model_name_or_path ~/HuggingFace/google/t5-small-lm-adapt/ --tag ${TAGS[$i]}
    bash ray/kill_serve.sh
    sleep 1m
done
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"
