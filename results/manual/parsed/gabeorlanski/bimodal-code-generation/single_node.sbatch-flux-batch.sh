#!/bin/bash
#FLUX: --job-name=stinky-carrot-3263
#FLUX: -c=16
#FLUX: -t=3600
#FLUX: --urgency=16

export WORLD_SIZE='2'
export MASTER_ADDR='${master_addr}.hpc.nyu.edu'

export WORLD_SIZE=2
echo "NODELIST="${SLURM_NODELIST}
echo "$(scontrol show hostnames "$SLURM_JOB_NODELIST")"
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR="${master_addr}.hpc.nyu.edu"
echo "MASTER_ADDR="$MASTER_ADDR
echo "${SLURM_NODEID}"
MASTER_PORT=$(shuf -i 10000-65500 -n 1)
srun $(which singularity) exec --nv \
	--overlay $SCRATCH/overlay-50G-10M.ext3:ro \
	/scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif \
	/bin/bash -c "
source /ext3/env.sh
conda activate adversarial-code
python -m torch.distributed.launch \
      --nproc_per_node=1 \
      --nnodes=$SLURM_NTASKS \
      --node_rank=$SLURM_NODEID \
      --master_addr=$MASTER_ADDR \
      --master_port=$MASTER_PORT \
      train.py --debug from_config data/sample_tensorized_cfg.yaml
"
