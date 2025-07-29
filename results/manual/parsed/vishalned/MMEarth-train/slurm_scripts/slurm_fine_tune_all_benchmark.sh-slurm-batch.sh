#!/bin/bash
#FLUX: --job-name=benchmarking
#FLUX: -c=4
#FLUX: -t=129600
#FLUX: --urgency=16

pretraining=gassl-resnet50
datasets=("geobench.m-bigearthnet" "geobench.m-so2sat")
linear_probe=False
output_dir_base="/projects/dereeco/data/global-lr/ConvNeXt-V2/results"
log_dir_base="/projects/dereeco/data/global-lr/ConvNeXt-V2/logs"
dataset_idx=$(((SLURM_ARRAY_TASK_ID - 1) / 2))
task_type_idx=$(( (SLURM_ARRAY_TASK_ID - 1) % 2 ))
dataset=${datasets[$dataset_idx]}
if [ $task_type_idx -eq 0 ]; then
    task_type="lp"
    linear_probe=True
else
    task_type="ft"
fi
output_dir="${output_dir_base}/${task_type}-${dataset}-${pretraining}"
log_dir="${log_dir_base}/${task_type}-${dataset}-${pretraining}"
echo "SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
echo "dataset: $dataset"
echo "task_type: $task_type"
echo "output_dir: $output_dir"
echo "log_dir: $log_dir"
python -m main_finetune \
    --model resnet50 \
    --batch_size 512 \
    --update_freq 2 \
    --lr 1e-3 \
    --epochs 100 \
    --warmup_epochs 0 \
    --layer_decay_type 'single' \
    --layer_decay 0.9 \
    --weight_decay 0.3 \
    --drop_path 0.1 \
    --reprob 0.25 \
    --mixup 0. \
    --cutmix 0. \
    --smoothing 0.2 \
    --finetune /projects/dereeco/data/global-lr/ConvNeXt-V2/results/gassl_pretrain/moco_tp.pth.tar \
    --output_dir "$output_dir" \
    --log_dir "$log_dir" \
    --data_set "$dataset" \
    --linear_probe "$linear_probe" \
    --pretraining "$pretraining"\
    --wandb True \
    --wandb_run_name "$task_type--$dataset--$pretraining" \
    --auto_resume False \
    --patch_size 32 \
    --input_size 112 \
    --use_orig_stem True \
    --run_on_test True 
