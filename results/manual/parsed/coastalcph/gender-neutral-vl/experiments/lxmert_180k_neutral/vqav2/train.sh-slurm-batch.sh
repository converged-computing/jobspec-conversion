#!/bin/bash
#FLUX: --job-name=vqa_lxmert180k_neutral
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='$(builtin cd ..; pwd)'

export PYTHONPATH=$(builtin cd ..; pwd)
. ../../main.config
name=lxmert_180k_neutral
task=1
task_name=VQA
configs=volta/config/original_lxmert.json
task_config_file=volta/config_tasks/all_trainval_tasks.yml
ckpt=${OUTS_DIR}/Pretrain_COCO_neutral/lxmert_180k/pytorch_model_0.bin
output=${OUTS_DIR}/${task_name}/${name}
logs=logs/${task_name}/${name}
echo "Task ${task}: ${task_name}"
mkdir -p $output
. /etc/profile.d/modules.sh
eval "$(conda shell.bash hook)"
conda activate genvlm
cd $CODE_DIR
python LXMERT/train_task.py \
	--config_file ${configs} --from_pretrained ${ckpt} \
	--tasks_config_file ${task_config_file} \
	--task $task \
	--adam_epsilon 1e-6 --adam_betas 0.9 0.999 --adam_correct_bias \
	--weight_decay 0.01 --warmup_proportion 0.1 --clip_grad_norm 5.0 \
	--output_dir ${output} \
	--logdir ${logs} \
	--use_wandb \
	--wandb_project ${WANDB_PROJ} \
	--wandb_entity ${WANDB_ENT} \
  	--wandb_run_name ${name}-${task_name}
conda deactivate
