#!/bin/bash
#SBATCH --job-name=llm
#SBATCH --account=scavenger
#SBATCH --output=logs/opt_llama_%A_%a.log
#SBATCH --error=logs/opt_llama_%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:rtxa5000:4
#SBATCH --mem=100gb
#SBATCH --time=1-12:00:00
#SBATCH --qos=normal
#SBATCH --array=0-9
#SBATCH --exclude=legacygpu00,legacygpu01,legacygpu02,legacygpu03,legacygpu04,legacygpu05,legacygpu06,legacygpu07

source /cmlscratch/pchiang/miniconda3/etc/profile.d/conda.sh
conda activate hug
I=0
for data_fraction in 0.2 0.4 0.6 0.8 1.0; do
model_size=opt6.7b
model_path=/fs/cml-projects/instruction_following/pretrained_models/${model_size}_sharded
model_config_path=/fs/cml-projects/instruction_following/pretrained_models/${model_size}_hf
name=${model_size}_self-instruct_dataf${data_fraction}_fsdp
ckpt_path=/fs/cml-projects/instruction_following/$name
command_list[$I]="python train.py --init_checkpoint_path $model_path \
--model_config_path $model_config_path \
--data_path data_instruct/alpaca.json --added_tokens 0 \
--act_checkpointing --lr 2e-5 --max_steps 2031 --accumulation_steps 4 --batch_size 8 \
--wandb --wb_project huggingface --wrapped_class_name OPTDecoderLayer \
--checkpoint_path $ckpt_path \
--wb_name $name --wb_id ${name}_v2 \
--data_fraction $data_fraction --hack"
I=$((I+1))
model_size=7B
model_path=/fs/nexus-scratch/pchiang/llama/${model_size}_sharded
model_config_path=/fs/nexus-scratch/pchiang/llama/${model_size}_hf
name=llama${model_size}_self-instruct_dataf${data_fraction}_fsdp
ckpt_path=/fs/cml-projects/instruction_following/$name
command_list[$I]="python train.py --init_checkpoint_path $model_path \
--model_config_path $model_config_path \
--data_path data_instruct/alpaca.json --added_tokens 1 \
--act_checkpointing --lr 2e-5 --max_steps 2031 --accumulation_steps 8 --batch_size 4 \
--wandb --wb_project huggingface --wrapped_class_name LlamaDecoderLayer \
--checkpoint_path $ckpt_path \
--wb_name $name --wb_id ${name}_v2 \
--data_fraction $data_fraction --hack"
I=$((I+1))
done
echo ${command_list[$SLURM_ARRAY_TASK_ID]}
eval ${command_list[$SLURM_ARRAY_TASK_ID]}
