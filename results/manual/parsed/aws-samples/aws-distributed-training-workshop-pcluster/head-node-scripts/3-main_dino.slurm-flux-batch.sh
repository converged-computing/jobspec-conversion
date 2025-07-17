#!/bin/bash
#FLUX: --job-name=crusty-despacito-7388
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --urgency=16

export WORLD_SIZE='8'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'

export WORLD_SIZE=8
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
source /home/ec2-user/.bashrc
conda activate pytorch-py38
cd /apps/aws-distributed-training-workshop-pcluster/head-node-scripts/
nnodes=$(yq '.train_scDINO.nnodes' scDINO_full_pipeline.yaml)
num_gpus=$(yq '.train_scDINO.num_gpus' scDINO_full_pipeline.yaml)
epochs=$(yq '.train_scDINO.epochs' scDINO_full_pipeline.yaml)
selected_channel_indices=$(yq '.meta.selected_channel_combination_per_run' scDINO_full_pipeline.yaml) 
channel_dict=$(yq '.meta.channel_dict' scDINO_full_pipeline.yaml) 
name_of_run=$(yq '.meta.name_of_run' scDINO_full_pipeline.yaml)
sk_save_dir=$(yq '.meta.output_dir' scDINO_full_pipeline.yaml)
save_dir_downstream_run=$sk_save_dir"/"$name_of_run
norm_per_channel_file=$save_dir_downstream_run"/mean_and_std_of_dataset.txt"
dino_vit_name=$(yq '.train_scDINO.dino_vit_name' scDINO_full_pipeline.yaml)
full_ViT_name=$dino_vit_name"_"$selected_channel_indices_str
srun python -m torch.distributed.run --nnodes $nnodes\
	      --nproc_per_node $num_gpus \
	      --rdzv_id $RANDOM \
	      --rdzv_backend c10d \
	      --rdzv_endpoint $head_node_ip:29500 \
	      pyscripts/main_dino.py \
	      --epochs $epochs \
	      --selected_channels $selected_channel_indices \
	      --channel_dict $channel_dict \
	      --norm_per_channel $norm_per_channel_file \
	      --name_of_run $name_of_run \
	      --output_dir $(yq '.meta.output_dir' scDINO_full_pipeline.yaml) \
	      --dataset_dir $(yq '.meta.dataset_dir' scDINO_full_pipeline.yaml) \
	      --full_ViT_name $full_ViT_name \
	      --dino_vit_name $dino_vit_name \
	      --saveckp_freq $(yq '.train_scDINO.saveckp_freq' scDINO_full_pipeline.yaml) \
	      --batch_size_per_gpu $(yq '.train_scDINO.batch_size_per_gpu' scDINO_full_pipeline.yaml) \
	      --saveckp_freq $(yq '.train_scDINO.saveckp_freq' scDINO_full_pipeline.yaml) \
	      --num_workers $(yq '.train_scDINO.num_workers' scDINO_full_pipeline.yaml) \
	      --dist_url $(yq '.train_scDINO.dist_url' scDINO_full_pipeline.yaml) \
	      --arch $(yq '.train_scDINO.hyperparameters.arch' scDINO_full_pipeline.yaml) \
	      --patch_size $(yq '.train_scDINO.hyperparameters.patch_size' scDINO_full_pipeline.yaml) \
	      --norm_last_layer $(yq '.train_scDINO.hyperparameters.norm_last_layer' scDINO_full_pipeline.yaml) \
	      --momentum_teacher $(yq '.train_scDINO.hyperparameters.momentum_teacher' scDINO_full_pipeline.yaml) \
	      --use_bn_in_head $(yq '.train_scDINO.hyperparameters.use_bn_in_head' scDINO_full_pipeline.yaml) \
	      --warmup_teacher_temp $(yq '.train_scDINO.hyperparameters.warmup_teacher_temp' scDINO_full_pipeline.yaml) \
	      --warmup_teacher_temp_epochs $(yq '.train_scDINO.hyperparameters.warmup_teacher_temp_epochs' scDINO_full_pipeline.yaml) \
	      --use_fp16 $(yq '.train_scDINO.hyperparameters.use_fp16' scDINO_full_pipeline.yaml) \
	      --weight_decay $(yq '.train_scDINO.hyperparameters.weight_decay' scDINO_full_pipeline.yaml) \
	      --weight_decay_end $(yq '.train_scDINO.hyperparameters.weight_decay_end' scDINO_full_pipeline.yaml) \
	      --clip_grad $(yq '.train_scDINO.hyperparameters.clip_grad' scDINO_full_pipeline.yaml) \
	      --freeze_last_layer $(yq '.train_scDINO.hyperparameters.freeze_last_layer' scDINO_full_pipeline.yaml) \
	      --lr $(yq '.train_scDINO.hyperparameters.lr' scDINO_full_pipeline.yaml) \
	      --warmup_epochs $(yq '.train_scDINO.hyperparameters.warump_epochs' scDINO_full_pipeline.yaml) \
              --min_lr $(yq '.train_scDINO.hyperparameters.min_lr' scDINO_full_pipeline.yaml) \
	      --optimizer $(yq '.train_scDINO.hyperparameters.optimizer' scDINO_full_pipeline.yaml) \
	      --drop_path_rate $(yq '.train_scDINO.hyperparameters.drop_path_rate' scDINO_full_pipeline.yaml) \
	      --local_crops_number $(yq '.train_scDINO.hyperparameters.local_crops_number' scDINO_full_pipeline.yaml) \
	      --train_datasetsplit_fraction $(yq '.meta.train_datasetsplit_fraction' scDINO_full_pipeline.yaml) \
	      --seed $(yq '.meta.seed' scDINO_full_pipeline.yaml) \
	      --center_crop $(yq '.meta.center_crop' scDINO_full_pipeline.yaml)
