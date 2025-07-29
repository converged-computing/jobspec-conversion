#!/bin/bash
#FLUX: --job-name=wmt
#FLUX: -c=64
#FLUX: --queue=gpu_p5
#FLUX: -t=28800
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'

cd ${SLURM_SUBMIT_DIR}
maindir=/gpfswork/rech/ncm/ulv12mq/lm-evaluation-harness
outputdir=$maindir/runs/outputs
[ -d $outputdir ] || mkdir $outputdir
modelname=bloom
modelpath=/gpfsdswork/dataset/HuggingFace_Models/bigscience/bloom # bigscience/bloom
tokeniserpath=$modelpath
task=wmt14_fr_en
template=xglm-fr-en-source+target
fewshotnum=1
seed=1234
timestamp=$(date +"%Y-%m-%dT%H_%M_%S")
output="model=$modelname.task=$task.templates=$template.fewshot=$fewshotnum.seed=$seed.timestamp=$timestamp"
batchsize=8
export CUDA_LAUNCH_BLOCKING=1
echo "Writing to: $output"
TRANSFORMERS_OFFLINE=1 HF_DATASETS_OFFLINE=1 \
TOKENIZERS_PARALLELISM=false \
python $maindir/main.py --model_api_name 'hf-causal' --model_args "use_accelerate=True,pretrained=$modelpath,tokenizer=$tokeniserpath,dtype=float16" \
    --task_name $task --template_names "$template" --num_fewshot $fewshotnum --seed $seed --output_path "$output" --batch_size $batchsize --no_tracking --use_cache --device cuda 
