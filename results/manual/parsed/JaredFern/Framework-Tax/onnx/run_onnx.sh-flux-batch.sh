#!/bin/bash
#FLUX: --job-name=bm-2080Ti
#FLUX: --queue=CLUSTER
#FLUX: -t=86400
#FLUX: --priority=16

source activate device_benchmarking;
PLATFORM="rtx8000"
DEVICE="cuda"
EXP_TAG=("fp16")
EXP_FLAG=("--use_fp16")
declare PROFILE_DIR="nsys-profiles";
EXP_NAME="pretrained-onnx-"${EXP_TAG[$SLURM_ARRAY_TASK_ID]}
declare -a MODELS=("bert" "resnet50")
for MODEL in ${MODELS[@]}; do
     /home/jaredfer/anaconda3/envs/device_benchmarking/bin/python  main_onnx.py \
        --exp_name $EXP_NAME --results_dir onnx_results \
        --model_name $MODEL --model_dir onnx_models \
        --device cuda --platform $PLATFORM --iters 100 $EXP_FLAG;
done;
