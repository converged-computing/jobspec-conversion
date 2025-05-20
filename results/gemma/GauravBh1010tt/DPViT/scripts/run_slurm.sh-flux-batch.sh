# Flux batch script equivalent

# Request resources
# Flux uses a different syntax for GPUs.  We'll request the nodes with the desired GPUs.
# Assuming a100 GPUs are available on the cluster and are identifiable.
# Adjust the 'gpu' parameter if needed to match the cluster's GPU naming convention.
# Flux doesn't have a direct equivalent to tasks-per-node, so we'll calculate the total number of cores.
# Flux doesn't have a direct equivalent to gpus-per-node, so we'll request the nodes with the desired GPUs.

# Flux uses a single --resources argument.
# The format is "resource_type=value,resource_type=value".
# We'll request 3 nodes, each with 2 a100 GPUs, 24 cores, and 64GB of memory.

# Flux doesn't have a direct equivalent to --account.  This is typically handled by cluster configuration.

# Flux doesn't have a direct equivalent to --output.  Output will be redirected to stdout/stderr.

# Flux doesn't have a direct equivalent to --time.  Walltime is managed by the cluster.

# Flux doesn't have a direct equivalent to --cpus-per-task. We'll request the total number of cores.

# Flux doesn't have a direct equivalent to --mem. We'll request the total memory.

# Flux doesn't have a direct equivalent to --tasks-per-node. We'll request the total number of cores.

# Flux doesn't have a direct equivalent to --gpus-per-node. We'll request the nodes with the desired GPUs.

# Activate the environment
source ../env_dpl/bin/activate

# Check GPU status
nvidia-smi

# Set environment variables
export NCCL_BLOCKING_WAIT=1
export MASTER_ADDR=$(hostname)

# Print information
echo "Launching python script"
echo "Master node: $MASTER_ADDR"

# Get the number of ranks (processes)
num_ranks=$(flux node list | grep -c "state=UP")

# Determine pretraining phase
pretrain=0

if [[ $pretrain -gt 0 ]]; then
  echo "Phase 1 pre-training ..."
  # Run the pretraining script
  flux run python -u ../main_dpvit.py --data_path ../data/mini_imagenet/train_comb \
    --output_dir exp/PKD_nw_PM_FT --evaluate_freq 50 --visualization_freq 50 --init_method=tcp://$MASTER_ADDR:3466 \
    --prod_mode=False --use_fp16 True --lr 0.0005 --epochs 1800 --image_path ../SMKD/img_viz \
    --global_crops_scale 0.4 1 --local_crops_scale 0.05 0.4 --num_workers=4 --n_gpus=$num_ranks \
    --lr_mix 0 --lr_noise 1 --K 64 --num_fore 40 --use_parts 0 \
    --lambda1 1 --lambda2 0 --lambda3 1 --batch_size_per_gpu 100 --use_DDP=1
else
  echo "Phase 2 tuning ..."
  # Run the tuning script
  flux run python -u ../main_dpvit.py --data_path ../data/mini_imagenet/train_comb \
    --pretrained_path exp/PKD_nw_PM_FT --pretrained_file checkpoint.pth --init_method=tcp://$MASTER_ADDR:3456 \
    --output_dir exp/PKD_nw_PM_FT_FT --evaluate_freq 5 --visualization_freq 5 --use_fp16 True --image_path ../SMKD/img_viz \
    --lr 0.0005 --epochs 150 --lambda1 1 --lambda2 0.45 --num_workers=4 --n_gpus=$num_ranks \
    --lambda3 0 --supervised_contrastive --batch_size_per_gpu 90 --global_crops_scale 0.4 1 \
    --lr_mix 1 --lr_noise 1 --K 64 --num_fore 40 \
    --local_crops_scale 0.05 0.4 --partition test --saveckp_freq 5 --use_DDP=1
fi