#!/bin/bash
#FLUX: --job-name=wobbly-squidward-6337
#FLUX: -N=2
#FLUX: -t=15
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export WORLD_SIZE='8'
export MASTER_ADDR='$(hostname)'
export MASTER_PORT='8964'
export NCCL_BLOCKING_WAIT='1 # Pytorch Lightning uses the NCCL backend for'
export PL_TORCH_DISTRIBUTED_BACKEND='nccl'

echo "Current working directory: `pwd`"
echo "Starting run at: `/bin/date`"
echo "Hostname: `hostname`"
export OMP_NUM_THREADS=1
export WORLD_SIZE=8
source /home/whilo/scratch/TATS/TATS/bin/activate
nodes_list=(`scontrol show hostname $SLURM_NODELIST`)
num_nodes=${#nodes_list[@]}
echo "[$(hostname)]: Allocated nodes: ${nodes_list[@]}"
hostname="$(hostname | cut -d '.' -f 1)"
master_node=${nodes_list[0]}
export MASTER_ADDR=$(hostname)
export MASTER_PORT=8964
num_gpus_per_node=$(srun -w"${master_node}" -n1 -N1 --mem=1M -c1 bash -c 'echo ${CUDA_VISIBLE_DEVICES}' | awk -F ',' "{ print NF }")
valid_nodes=$(printf ",%s" "${nodes_list[@]}")
valid_nodes="${valid_nodes:1}"
num_valid_nodes=$num_nodes
echo "WORLD_SIZE: ${WORLD_SIZE}"
echo "Valid nodes: ${valid_nodes}"
echo "Num valid nodes: ${num_valid_nodes}"
echo "Master node: ${master_node}"
echo "Gpus per node: ${num_gpus_per_node}"
export NCCL_BLOCKING_WAIT=1 # Pytorch Lightning uses the NCCL backend for
                            # inter-GPU communication by default. Set this
                            # variable to avoid timeout errors. (CAN CAUSE LARGE
                            # OVERHEAD)
echo "Running job with the NCCL backend"
export PL_TORCH_DISTRIBUTED_BACKEND=nccl
echo "Running the following command: "
echo "srun -w"${valid_nodes}" -N${num_valid_nodes} -n${WORLD_SIZE} \
    -c${SLURM_CPUS_PER_TASK} -o ./output/demo_gloo_lightning_output.out -D"$(dirname "$(pwd)")" \
    python /home/whilo/scratch/TATS/train_vqgan.py --embedding_dim 256 --n_codes 16384 --n_hiddens 32 --downsample 4 8 8 --no_random_restart \
                      --gpus=${num_gpus_per_node} --nnodes=${num_valid_nodes} --sync_batchnorm --batch_size 2 \
                      --num_workers 32 --accumulate_grad_batches 6 \
                      --progress_bar_refresh_rate 500 --max_steps 2000 --gradient_clip_val 1.0 --lr 3e-5 \
                      --data_path /home/whilo/scratch/TATS/data/sky_timelapse_small  --image_folder --default_root_dir /home/whilo/scratch/TATS/checkpoints \
                      --resolution 128 --sequence_length 16 --discriminator_iter_start 10000 --norm_type batch \
                      --perceptual_weight 4 --image_gan_weight 1 --video_gan_weight 1  --gan_feat_weight 4
"
srun -w"${valid_nodes}" -N${num_valid_nodes} -n${WORLD_SIZE} \
    -c${SLURM_CPUS_PER_TASK} -o ./output/demo_gloo_lightning_output.out -D"$(dirname "$(pwd)")" \
    python /home/whilo/scratch/TATS/train_vqgan.py --embedding_dim 256 --n_codes 16384 --n_hiddens 32 --downsample 4 8 8 --no_random_restart \
                      --gpus=${num_gpus_per_node} --nnodes=${num_valid_nodes} --sync_batchnorm --batch_size 2 \
                      --num_workers 32 --accumulate_grad_batches 6 \
                      --progress_bar_refresh_rate 500 --max_steps 2000 --gradient_clip_val 1.0 --lr 3e-5 \
                      --data_path /home/whilo/scratch/TATS/data/sky_timelapse_small  --image_folder --default_root_dir /home/whilo/scratch/TATS/checkpoints \
                      --resolution 128 --sequence_length 16 --discriminator_iter_start 10000 --norm_type batch \
                      --perceptual_weight 4 --image_gan_weight 1 --video_gan_weight 1  --gan_feat_weight 4
