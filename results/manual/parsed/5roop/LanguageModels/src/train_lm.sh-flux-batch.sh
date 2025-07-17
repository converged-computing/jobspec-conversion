#!/bin/bash
#FLUX: --job-name=crusty-rabbit-4983
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

set -eu -o pipefail
config_sh=$1 # Config sh file with experimental settings
source $config_sh # Load all variables to here
num_processes=16
SEED=2810
tpu_call=""
pad_to_max=""
if [[ $2 == "tpu" || $2 == "TPU" ]] ; then
    tpu_call="transformers/examples/pytorch/xla_spawn.py --num_cores 8"
    pad_to_max="--pad_to_max_length"
    echo "Running traning on TPU..."
else
    echo "Not running training on TPU..."
fi
python $tpu_call src/run_mlm.py $pad_to_max $model_name_or_path --preprocessing_num_workers $num_processes $tokenizer_name $model_type $tokenizer_name $max_steps $warmup_ratio --train_file $train_file --max_seq_length $max_seq_length $line_by_line --output_dir $output_dir $do_train --per_device_train_batch_size $batch_train $overwrite_cache $overwrite_output_dir --gradient_accumulation_steps $gradient_accumulation_steps --save_steps $save_steps --learning_rate $learning_rate --seed $SEED --logging_steps $logging_steps $piece_masking
