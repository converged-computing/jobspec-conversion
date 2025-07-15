#!/bin/bash
#FLUX: --job-name=vqa_lxmert3m_neutral-eval
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='$(builtin cd ..; pwd)'

export PYTHONPATH=$(builtin cd ..; pwd)
CODE_DIR=/home/sxk199/projects/multimodal-gender-bias/src/LXMERT
ANNOS_DIR=${BASE_DIR}/data/volta/mscoco/annotations
FEATS_DIR=${BASE_DIR}/data/volta/mscoco/resnet101_faster_rcnn_genome_imgfeats
WANDB_ENT="coastal-multimodal-gb"
WANDB_PROJ="MM-GB"
name=lxmert_3m_neutral
task=1
task_name=VQA
configs=volta/config/lxmert.json
ckpt=${OUTS_DIR}/${task_name}/${name}/pytorch_model_best.bin
output=${OUTS_DIR}/${task_name}/${name}
logs=logs/${task_name}/${name}
echo "Task ${task}: ${task_name}"
task_config_file=volta/config_tasks/all_trainval_tasks.yml
python LXMERT/eval_task.py \
	--config_file ${configs} \
	--from_pretrained ${ckpt} \
	--tasks_config_file ${task_config_file} \
	--task $task \
	--output_dir ${output} \
	--logdir ${logs} \
	--save_name "val"
task_config_file=volta/config_tasks/all_test_tasks.yml
python LXMERT/eval_task.py \
	--config_file ${configs} \
	--from_pretrained ${ckpt} \
	--tasks_config_file ${task_config_file} \
	--task $task \
	--output_dir ${output} \
	--logdir ${logs} \
	--save_name "test"
conda deactivate
