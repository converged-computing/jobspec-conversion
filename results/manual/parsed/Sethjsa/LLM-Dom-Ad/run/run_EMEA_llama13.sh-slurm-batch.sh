#!/bin/bash
#FLUX: --job-name=EMEA
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'

cd /scratch/saycock/scripts/runs/
module purge
source /home/$USER/.bashrc
conda activate dada2
maindir=/scratch/saycock/topic/lm-evaluation-harness
outputdir=/scratch/saycock/topic/lm-evaluation-harness/outputs
[ -d $outputdir ] || mkdir $outputdir
modelname=llama-13b
modelpath=meta-llama/Llama-2-13b-hf
tokeniserpath=$modelpath
dataset=EMEA
source=$1
target=$2
task="$dataset-$source-$target"
name=$4
fewshotnum=$3
seed=1234
batchsize=8
timestamp=$(date +"%Y-%m-%dT%H_%M_%S")
output="task=$task.modifier=$name.seed=$seed.timestamp=$timestamp"
topic_flag=$5
echo $topic_flag
topic_model=$6
export CUDA_LAUNCH_BLOCKING=1
echo "Writing to: $output"
TRANSFORMERS_OFFLINE=1 HF_DATASETS_OFFLINE=1 \
TOKENIZERS_PARALLELISM=false \
python $maindir/main.py --model 'hf-causal-experimental' --model_args "use_accelerate=True,pretrained=$modelpath,tokenizer=$tokeniserpath" \
    --tasks=$task --num_fewshot=$fewshotnum --seed=$seed --write_out --output_base_path="$outputdir" --output_template="$output" \
    --no_cache --batch_size $batchsize --device cuda --bootstrap_iters=2 \
    $topic_flag --topic_model="$topic_model"
