#!/bin/bash
#SBATCH --job-name=pytorch_transConv
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpulab02
#SBATCH --qos=gpulab02
#SBATCH --constraint=ntasks-per-node=6

env_name="trans"
seq_lens=(96 192 336 720)
label_lens=(48)
pred_lens=(96)
features=("M" "S")
python_scripts=("pred_ours.py")
data_sets=("ETTh1" "ETTm1"  "WTH")
enc_layers=(3)
n_heads=(8 9 10)
factor=(4 5 6)
d_models=(64 128 256 512 1024)
source activate $env_name
for task in "${seq_lens[@]}"
do
  for feature in "${features[@]}"
do
    for data_set in "${data_sets[@]}"
    do
        for pred_len in "${pred_lens[@]}"
        do
            # Loop through Python scripts
            for python_script in "${python_scripts[@]}"
            do
                # Print prompt message with script name and parameters, and write it to output file
                prompt_message=("Processing script '$python_script' with parameters: seq_len=$task, pred_len=$pred_len, features=$feature, dataset=$data_set")
                echo "${prompt_message[@]}"
                # Run current Python script with specified parameters and append output to file
                python $python_script --seq_len $task --pred_len $pred_len --features $feature --dataset $data_set
            done
        done
    done
done
done
