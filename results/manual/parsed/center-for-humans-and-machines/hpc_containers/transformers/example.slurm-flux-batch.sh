#!/bin/bash
#FLUX: --job-name=crusty-parsnip-2446
#FLUX: -N=2
#FLUX: -c=72
#FLUX: -t=900
#FLUX: --urgency=16

export OMP_NUM_THREADS='18'
export OMP_PLACES='cores'

source /etc/profile.d/modules.sh
module purge
module load apptainer
export OMP_NUM_THREADS=18
export OMP_PLACES=cores
srun apptainer exec \
	--nv -B .:"$HOME" \
	transformers.sif torchrun \
		--nnodes="$SLURM_NNODES" \
		--nproc-per-node=gpu \
		--rdzv-id="$SLURM_JOBID" \
		--rdzv-endpoint=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1) \
		--rdzv-backend="c10d" \
		example.py --lr=4e-5 --bs=2
