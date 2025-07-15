#!/bin/bash
#FLUX: --job-name=TR_cn_t_post_hand_newloss_1
#FLUX: -N=4
#FLUX: -c=12
#FLUX: --queue=rtx8000,a100_2,a100_1,tandon_a100_2,tandon_a100_1,stake_a100_1,stake_a100_2
#FLUX: -t=158400
#FLUX: --urgency=16

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
