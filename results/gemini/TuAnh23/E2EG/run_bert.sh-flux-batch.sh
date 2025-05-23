#!/bin/bash

#FLUX: -N 1
#FLUX: -n 1
#FLUX: --cpus-per-task=3
#FLUX: --gpus-per-task=1
#FLUX: --job-name=bert_classifier_products
#FLUX: -t 12h
#FLUX: --output=flux_output_%J.out

# Note: The Slurm '--partition=gpu_shared' directive does not have a direct
# generic equivalent in Flux. If 'gpu_shared' corresponds to a specific Flux
# queue, you would add: #FLUX: --queue=<flux_queue_name>
# Otherwise, the GPU request (--gpus-per-task=1) ensures a GPU is allocated.

nvidia-smi

module purge
module load 2021
module load Anaconda3/2021.05

head /proc/sys/vm/overcommit_memory

# Your job starts in the directory where you call flux submit
# Activate your environment
source activate giant-xrt
which python
# Run your code
export WANDB_DIR=$HOME
experiment_name=bert_classifier_products
runs=5
mkdir experiments/${experiment_name}
mkdir models/${experiment_name}
# Download data
cd data/proc_data_multi_task
dataset=ogbn-products
subset=""  # Whether to take a subset of the data. If yes: "_subset". If no: "".
bash download_data.sh ${dataset}
cd ../../
# Process data
# bash proc_data_multi_task.sh ${dataset} ${subset}
# Move files to scratch node
echo "Moving data to scratch..."
# $TMPDIR is typically set by Flux on the execution node (e.g., /tmp)
# FLUX_JOB_TMPDIR could also be used if a job-specific, pre-created temp dir is preferred.
tmp_dir="$TMPDIR"/tuanh_scratch
mkdir -p ${tmp_dir} # Use -p to avoid error if it already exists, though fresh $TMPDIR usually means it won't
# Copy data folder
cp -r data ${tmp_dir}
# Copy model folder if it already exists
if [ -d "models/${experiment_name}" ]
then
  mkdir -p ${tmp_dir}/models # Use -p
  cp -r models/${experiment_name} ${tmp_dir}/models
fi
# Copy experiment folder if it already exists
if [ -d "experiments/${experiment_name}" ]
then
  mkdir -p ${tmp_dir}/experiments # Use -p
  cp -r experiments/${experiment_name} ${tmp_dir}/experiments
fi
# Copy cache folder if it already exists
if [ -d "models/cache" ]
then
  # Ensure the target models directory exists in tmp_dir
  mkdir -p ${tmp_dir}/models 
  cp -r models/cache ${tmp_dir}/models
fi
data_dir=${tmp_dir}/data/proc_data_multi_task/${dataset}${subset}
model_dir=${tmp_dir}/models/${experiment_name}
experiment_dir=${tmp_dir}/experiments/${experiment_name}
cache_dir=${tmp_dir}/models/cache
# No matter what happens, we copy the temp output folders back to our login node
# Ensure target directories exist in $HOME before copying
trap 'mkdir -p $HOME/UvA_Thesis_pecosEXT/experiments; mkdir -p $HOME/UvA_Thesis_pecosEXT/models; mkdir -p $HOME/UvA_Thesis_pecosEXT/data/proc_data_multi_task/${dataset}${subset}; \
      cp -r ${experiment_dir} $HOME/UvA_Thesis_pecosEXT/experiments; \
      cp -r ${model_dir} $HOME/UvA_Thesis_pecosEXT/models; \
      if [ -d "${cache_dir}" ]; then cp -r ${cache_dir} $HOME/UvA_Thesis_pecosEXT/models; fi; \
      if [ -d "${data_dir}/HierarchialLabelTree" ]; then cp -r ${data_dir}/HierarchialLabelTree $HOME/UvA_Thesis_pecosEXT/data/proc_data_multi_task/${dataset}${subset}; fi' EXIT

start_seed=0
end_seed=$((runs-1)) # Using explicit arithmetic substitution for clarity, though original worked.
for (( seed=$start_seed; seed<=$end_seed; seed++ ))
do
  if [ -d "${experiment_dir}/run${seed}" ]
	then
	  echo "Results for run${seed} exists, skip this run"
	  continue 1
	fi
  mkdir -p ${model_dir}/run${seed} # Use -p
  mkdir -p ${experiment_dir}/run${seed} # Use -p
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