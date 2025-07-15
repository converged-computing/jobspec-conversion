#!/bin/bash
#FLUX: --job-name=m-diff
#FLUX: -c=4
#FLUX: -t=21540
#FLUX: --priority=16

echo Loading Anaconda...
module purge
module load gcc/6.4.0
module load cuda/11.1.1
source activate /ibex/ai/home/xum/miniconda3/envs/denoiseloc
echo `hostname`
which python
nvidia-smi
N=$SLURM_ARRAY_TASK_ID
BS=32
SNR=0.$N
sleep $((RANDOM % 60))
dset_name=hl
ctx_mode=video_tef
v_feat_types=slowfast_clip
t_feat_type=clip 
results_root=results
exp_id=snr_$SNR
train_path=data/highlight_train_release.jsonl
eval_path=data/highlight_val_release.jsonl
eval_split_name=val
feat_root=features
v_feat_dim=0
v_feat_dirs=()
if [[ ${v_feat_types} == *"slowfast"* ]]; then
  v_feat_dirs+=(${feat_root}/slowfast_features)
  (( v_feat_dim += 2304 ))  # double brackets for arithmetic op, no need to use ${v_feat_dim}
fi
if [[ ${v_feat_types} == *"clip"* ]]; then
  v_feat_dirs+=(${feat_root}/clip_features)
  (( v_feat_dim += 512 ))
fi
if [[ ${t_feat_type} == "clip" ]]; then
  t_feat_dir=${feat_root}/clip_text_features/
  t_feat_dim=512
else
  echo "Wrong arg for t_feat_type."
  exit 1
fi
bsz=$BS
set -ex
PYTHONPATH=$PYTHONPATH:. python moment_detr/train.py \
--dset_name ${dset_name} \
--ctx_mode ${ctx_mode} \
--train_path ${train_path} \
--eval_path ${eval_path} \
--eval_split_name ${eval_split_name} \
--v_feat_dirs ${v_feat_dirs[@]} \
--v_feat_dim ${v_feat_dim} \
--t_feat_dir ${t_feat_dir} \
--t_feat_dim ${t_feat_dim} \
--results_root ${results_root} \
--exp_id ${exp_id} \
--use_sparse_rcnn 0 \
--use_dynamic_conv 1 \
--use_attention 1 \
--snr_scale $SNR \
${@:1}
