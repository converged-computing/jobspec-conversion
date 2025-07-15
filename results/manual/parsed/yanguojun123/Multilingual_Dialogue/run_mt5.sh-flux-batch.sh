#!/bin/bash
#FLUX: --job-name=$4
#FLUX: -t=864000
#FLUX: --urgency=16

CUR_DATA_DIR=$DATA_DIR
port=$(($(date +%N)%30000))
sbatch <<EOT
source activate
conda activate mul
cd $2
python -m torch.distributed.launch --nproc_per_node=1 --master_port $port $3.py \
--source_language '$5' \
--target_language '$6' \
--train_file_name '$7' \
--val_file_name '$8' \
--test_file_name '$9' \
--save_file_name '$4.json' \
--writer_dir 'tensorboard_$4/' \
--dialogue_model_output_path '$4_model/' \
--eval_all_checkpoints \
--change_parameter \
${10}
EOT
