#!/bin/bash
#FLUX: --job-name=nerdy-hobbit-3631
#FLUX: --urgency=16

export MASTER_ADDR='`/bin/hostname -s`'
export MASTER_PORT='29500'
export NEPTUNE_API_TOKEN='{6. neptune API token}'

set +x
cd {3.where your 'SwiFT' project is located}
source /usr/anaconda3/etc/profile.d/conda.sh
conda activate py39
TRAINER_ARGS='--accelerator gpu --max_epochs 10 --precision 16 --num_nodes {1.number of nodes} --devices {2.number of gpus} --strategy DDP'
MAIN_ARGS='--loggername neptune --classifier_module v6 --dataset_name S1200 --image_path {4.your data dir}'  
DATA_ARGS='--batch_size 8 --num_workers 8  --input_type rest'
DEFAULT_ARGS='--project_name {5.neptune_id/project_dir}' # change this
OPTIONAL_ARGS='--c_multiplier 2 --last_layer_full_MSA True --clf_head_version v1 --downstream_task sex --use_scheduler --gamma 0.5 --cycle 0.5' 
RESUME_ARGS=''
export MASTER_ADDR=`/bin/hostname -s`
export MASTER_PORT=29500
export NEPTUNE_API_TOKEN="{6. neptune API token}"
srun bash -c "
source export_DDP_vars.sh
python project/main.py $TRAINER_ARGS $MAIN_ARGS $DEFAULT_ARGS $DATA_ARGS $OPTIONAL_ARGS $RESUME_ARGS \
--dataset_split_num 1 --seed 1 --learning_rate 5e-5 --model swin4d_ver7 --depth 2 2 6 2 --embed_dim 36 --sequence_length 20 --first_window_size 4 4 4 4 --window_size 4 4 4 4 --img_size 96 96 96 20"
