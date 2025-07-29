#!/bin/bash
#SBATCH --job-name=TR_cn_t_post_hand_newloss_1
#SBATCH --output=%x.out
#SBATCH --mail-user=[replace
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=80GB
#SBATCH --time=1-20:00:00
#SBATCH --constraint=ntasks-per-node=1

export LOGLEVEL='INFO'

module purge
nodes=($(scontrol show hostnames $SLURM_JOB_NODELIST))
echo $nodes
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
echo $SLURM_JOB_ID
echo $head_node_ip:29500
srun singularity exec --nv \
	    --overlay ../overlay_1.ext3:ro \
	    /scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif \
	    /bin/bash -c "source /ext3/env.sh; \
		torchrun --nnodes 4 \
		--nproc_per_node 1 \
		--rdzv_id $SLURM_JOB_ID \
		--rdzv_backend c10d \
		--rdzv_endpoint $head_node_ip:29500 \
		train_DDP.py --config_file ./configs/cn_t_post_hand_newloss_1_d1_seen.yaml"
