#!/bin/bash
#FLUX: --job-name=cpt-fpt-resume-200b
#FLUX: -N=7
#FLUX: -c=64
#FLUX: --queue=MoE
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'
export NCCL_DEBUG='INFO'
export LOGLEVEL='INFO'

source ~/anaconda3/bin/activate smoe
num_nodes=7         # should match with --nodes
num_gpu_per_node=8  # should match with --gres
export OMP_NUM_THREADS=8
export NCCL_DEBUG=INFO
export LOGLEVEL=INFO
{
    # model_type="llama"
    # pretrained_model=/mnt/petrelfs/share_data/quxiaoye/models/llama_7B
    model_type="llama_moe"
    # pretrained_model=/mnt/petrelfs/share_data/quxiaoye/models/llama_7B_MoE_16Select4-l2_norm_bak
    pretrained_model=/mnt/petrelfs/share_data/quxiaoye/models/tzhu_model_bak/cpt-moe-fpt-64gpus-bs16_2-zero1default-1600316/checkpoint-23000
    tokenizer_path=/mnt/petrelfs/share_data/quxiaoye/models/llama_7B
    # dataset_dir=/mnt/petrelfs/share_data/quxiaoye/pretrain_LLAMA_all_data_processed
    dataset_dir=/mnt/petrelfs/share_data/quxiaoye/pretrain_LLAMA_all_data_processed_v2
    lr=2e-5
    final_lr_portion=0.5
    per_device_train_batch_size=16
    per_device_eval_batch_size=1
    gradient_accumulation_steps=2
    block_size=2048
    num_tokens="2*10^11"
    deepspeed_config_file=conf/deepspeed/bf16_zero1_default.json
    max_steps=$(echo "${num_tokens} / ($block_size * $per_device_train_batch_size * $gradient_accumulation_steps * $num_nodes * $num_gpu_per_node)" | bc)
    max_train_samples=$(echo "${num_tokens} / $block_size" | bc)
    echo "max_steps: $max_steps"
    echo "max_train_samples: $max_train_samples"
    global_bs=$(echo "$per_device_train_batch_size * $gradient_accumulation_steps * $num_nodes * $num_gpu_per_node" | bc)
    echo "global batch size: $global_bs"
    tokens_per_batch=$(echo "$global_bs * $block_size" | bc)
    echo "#tokens/batch: $tokens_per_batch"
    data_cache=resources/cache
    output_dir=outputs/$SLURM_JOB_NAME-$SLURM_JOB_ID
    # output_dir=outputs/$SLURM_JOB_NAME
    mkdir -p $output_dir
    scontrol write batch_script $SLURM_JOBID $output_dir/sbatch.sh
    echo "output_dir: $output_dir"
    nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIS ) )
    nodes_array=($nodes)
    head_node=${nodes_array[0]}
    head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
    echo "Node: $head_node"
    echo "Node IP: $head_node_ip"
            # --resume_from_checkpoint /mnt/petrelfs/share_data/quxiaoye/models/tzhu_model_bak/cpt-moe-fpt-64gpus-bs16_2-zero1default-1600316/checkpoint-23000 \
    srun torchrun \
        --nnodes ${num_nodes} \
        --nproc_per_node ${num_gpu_per_node} \
        --node_rank $SLURM_NODEID \
        --rdzv_id $RANDOM \
        --rdzv_backend c10d \
        --rdzv_endpoint $head_node:29518 \
        smoe/entrypoint/cpt/cpt_fpt.py \
            --ignore_data_skip \
            --deepspeed ${deepspeed_config_file} \
            --model_name_or_path ${pretrained_model} \
            --model_type ${model_type} \
            --tokenizer_name_or_path ${tokenizer_path} \
            --dataset_dir ${dataset_dir} \
            --data_cache_dir ${data_cache} \
            --validation_split_percentage 0.001 \
            --per_device_train_batch_size ${per_device_train_batch_size} \
            --per_device_eval_batch_size ${per_device_eval_batch_size} \
            --do_train \
            --seed $RANDOM \
            --bf16 \
            --num_train_epochs 1 \
            --final_lr_portion ${final_lr_portion} \
            --optim adamw_torch \
            --adam_beta1 0.9 \
            --adam_beta2 0.95 \
            --learning_rate ${lr} \
            --weight_decay 0.1 \
            --max_grad_norm 1.0 \
            --warmup_steps 2000 \
            --max_steps ${max_steps} \
            --max_train_samples ${max_train_samples} \
            --logging_strategy steps \
            --logging_steps 1 \
            --save_strategy steps \
            --save_total_limit 2 \
            --save_steps 1000 \
            --dataloader_num_workers 0 \
            --gradient_accumulation_steps ${gradient_accumulation_steps} \
            --block_size ${block_size} \
            --output_dir ${output_dir} \
            --overwrite_output_dir \
            --ddp_timeout 30000 \
            --logging_first_step True \
            --torch_dtype bfloat16 \
            --ddp_find_unused_parameters False \
            --gradient_checkpointing \
            --report_to none \
            --log_level info
}
