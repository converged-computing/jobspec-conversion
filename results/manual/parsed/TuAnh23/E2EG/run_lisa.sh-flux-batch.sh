#!/bin/bash
#FLUX: --job-name=ExampleJob
#FLUX: -c=6
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
experiment_name=mtask_roberta
cd data/proc_data_multi_task
dataset=ogbn-arxiv
subset=""  # Whether to take a subset of the data. If yes: "_subset". If no: "".
bash download_data.sh ${dataset}
cd ../../
bash proc_data_multi_task.sh ${dataset} ${subset}
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
runs=1
trap 'cp -r ${experiment_dir} $HOME/UvA_Thesis_pecosEXT/experiments; cp -r ${model_dir} $HOME/UvA_Thesis_pecosEXT/models; cp -r ${cache_dir} $HOME/UvA_Thesis_pecosEXT/models; cp -r ${data_dir}/HierarchialLabelTree $HOME/UvA_Thesis_pecosEXT/data/proc_data_multi_task/${dataset}${subset}' EXIT
params_path=data/proc_data_multi_task/params_mtask_${dataset}${subset}.json
bash multi_task_pipeline.sh ${data_dir} ${model_dir} ${experiment_dir} ${cache_dir} ${params_path} ${runs}
bash encode_mtask.sh ${data_dir} ${model_dir} ${experiment_dir} ${cache_dir} ${params_path} ${runs}
