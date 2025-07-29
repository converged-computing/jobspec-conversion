#!/bin/bash
#SBATCH --job-name=diabla
#SBATCH --account=ncm@a100
#SBATCH --output=diabla_opt_%j.out
#SBATCH --error=diabla_opt_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:8
#SBATCH --time=12:00:00
#SBATCH --partition=gpu_p5
#SBATCH --constraint=a100,ntasks-per-node=1

export CUDA_LAUNCH_BLOCKING='1'

cd ${SLURM_SUBMIT_DIR}
maindir=/gpfswork/rech/ncm/ulv12mq/lm-evaluation-harness
outputdir=$maindir/outputs
[ -d $outputdir ] || mkdir $outputdir
modelname=opt
modelpath=/gpfsdswork/dataset/HuggingFace_Models/facebook/opt-66b # facebook/opt-66b # you may need to download a local copy
tokeniserpath=$modelpath
task=diabla # default task
template=xglm
fewshotnum=1
seed=1234
timestamp=$(date +"%Y-%m-%dT%H_%M_%S")
output="model=$modelname.task=$task.templates=$template.fewshot=$fewshotnum.seed=$seed.timestamp=$timestamp"
batchsize=8
echo "Writing to: $output"
export CUDA_LAUNCH_BLOCKING=1
TRANSFORMERS_OFFLINE=1 HF_DATASETS_OFFLINE=1 \
TOKENIZERS_PARALLELISM=false \
python $maindir/main.py --model_api_name 'hf-causal' --model_args "use_accelerate=True,pretrained=$modelpath,tokenizer=$tokeniserpath,dtype=float32" \
    --task_name $task --template_names "$template" --num_fewshot $fewshotnum --seed $seed --output_path "$output" --batch_size $batchsize --no_tracking --use_cache --device cuda
