#!/bin/bash
#SBATCH --output=array_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=1
#SBATCH --time=2-08:00:00

export PYTHONPATH='$PYTHONPATH:$PWD'

cd $HOME/workspace || exit
source load.sh
exp_name=CoPrompt
trainer=CoPrompt
train_bash=scripts/base2new_train_coprompt.sh
test_bash=scripts/base2new_test_coprompt.sh
export PYTHONPATH="$PYTHONPATH:$PWD"
for seed in 1; do
  for dataset in sun397; do
    for wstd in 0.001 0.012 0.08; do
      export WEIGHT_STD=$wstd
      for max_epoch in 8 16; do
        export MAX_EPOCH=$max_epoch
        for nctxt in 1 2 3 4; do
          export NUM_CONTEXT=$nctxt
          for momentum in 0.0 0.9; do
            export MOMENTUM=$momentum
            export exp_name=CoPrompt_m${momentum}_wstd${wstd}_nctxt${nctxt}_maxepoch${max_epoch}
            output_dir="/home/ataboadawarmer/data/fomo/output/${exp_name}/train_base/${dataset}/shots_16/CoPrompt/seed${seed}"
            mkdir -p "$output_dir"
            echo "Runing the first phase job and save the output to ${output_dir}"
            bash $train_bash $dataset $seed $exp_name > "${output_dir}/output.log" 2>&1 &
          done
        done
        wait
      done
    done
  done
done
for seed in 1; do
  for dataset in sun397; do
    for wstd in 0.001 0.012 0.08; do
      export WEIGHT_STD=$wstd
      for max_epoch in 8 16; do
        export MAX_EPOCH=$max_epoch
        for nctxt in 1 2 3 4; do
          export NUM_CONTEXT=$nctxt
          for momentum in 0.0 0.9; do
            export MOMENTUM=$momentum
            export exp_name=CoPrompt_m${momentum}_wstd${wstd}_nctxt${nctxt}_maxepoch${max_epoch}
            output_dir="/home/ataboadawarmer/data/fomo/output/${exp_name}/test_new/${dataset}/shots_16/CoPrompt/seed${seed}"
            mkdir -p "$output_dir"
            echo "Runing the first phase job and save the output to ${output_dir}"
            bash $test_bash $dataset $seed $exp_name $MAX_EPOCH > "${output_dir}/output.log" 2>&1 &
          done
        done
        wait
      done
    done
  done
done
