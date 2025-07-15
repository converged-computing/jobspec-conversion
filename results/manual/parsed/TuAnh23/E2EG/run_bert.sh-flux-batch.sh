#!/bin/bash
#FLUX: --job-name=bert_classifier_products
#FLUX: -c=3
#FLUX: --queue=gpu_shared
#FLUX: -t=43200
#FLUX: --priority=16

export WANDB_DIR='$HOME'

nvidia-smi
module purge
module load 2021
module load Anaconda3/2021.05
head /proc/sys/vm/overcommit_memory
source activate giant-xrt
which python
export WANDB_DIR=$HOME
experiment_name=bert_classifier_products
runs=5
mkdir experiments/${experiment_name}
mkdir models/${experiment_name}
cd data/proc_data_multi_task
dataset=ogbn-products
subset=""  # Whether to take a subset of the data. If yes: "_subset". If no: "".
bash download_data.sh ${dataset}
cd ../../
echo "Moving data to scratch..."
tmp_dir="$TMPDIR"/tuanh_scratch
mkdir ${tmp_dir}
cp -r data ${tmp_dir}
if [ -d "models/${experiment_name}" ]
then
  mkdir ${tmp_dir}/models
  cp -r models/${experiment_name} ${tmp_dir}/models
fi
if [ -d "experiments/${experiment_name}" ]
then
  mkdir ${tmp_dir}/experiments
  cp -r experiments/${experiment_name} ${tmp_dir}/experiments
fi
if [ -d "models/cache" ]
then
  cp -r models/cache ${tmp_dir}/models
fi
data_dir=${tmp_dir}/data/proc_data_multi_task/${dataset}${subset}
model_dir=${tmp_dir}/models/${experiment_name}
experiment_dir=${tmp_dir}/experiments/${experiment_name}
cache_dir=${tmp_dir}/models/cache
trap 'cp -r ${experiment_dir} $HOME/UvA_Thesis_pecosEXT/experiments; cp -r ${model_dir} $HOME/UvA_Thesis_pecosEXT/models; cp -r ${cache_dir} $HOME/UvA_Thesis_pecosEXT/models; cp -r ${data_dir}/HierarchialLabelTree $HOME/UvA_Thesis_pecosEXT/data/proc_data_multi_task/${dataset}${subset}' EXIT
start_seed=0
end_seed=runs-1
for (( seed=$start_seed; seed<=$end_seed; seed++ ))
do
  if [ -d "${experiment_dir}/run${seed}" ]
	then
	  echo "Results for run${seed} exists, skip this run"
	  continue 1
	fi
  mkdir ${model_dir}/run${seed}
  mkdir ${experiment_dir}/run${seed}
  python -u baseline_models/bert_classifier.py \
    --model_dir ${model_dir}/run${seed} \
    --experiment_dir ${experiment_dir}/run${seed} \
    --seed ${seed} \
    --raw-text-path ${data_dir}/X.all.txt \
    --text_tokenizer_path ${data_dir}/xrt_models/text_encoder/text_tokenizer \
    --dataset ${dataset} \
    --epochs 5 \
    | tee -a ${experiment_dir}/run${seed}/train.log
done
