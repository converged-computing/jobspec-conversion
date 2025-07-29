#!/bin/bash
#FLUX: --job-name=WMT
#FLUX: -c=32
#FLUX: -t=43200
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'

cd ${SLURM_SUBMIT_DIR}
maindir=/gpfswork/rech/ncm/ulv12mq/lm-evaluation-harness
outputdir=$maindir/runs/outputs
[ -d $outputdir ] || mkdir $outputdir
modelname=t0
modelpath=bigscience/T0
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
python $maindir/main.py --model_api_name 'hf-seq2seq' --model_args "use_accelerate=True,pretrained=$modelpath,tokenizer=$tokeniserpath,dtype=float32" \
    --task_name $task --template_names "$template" --num_fewshot $fewshotnum --seed $seed --output_path "$output" --batch_size $batchsize --no_tracking --use_cache --device cuda
