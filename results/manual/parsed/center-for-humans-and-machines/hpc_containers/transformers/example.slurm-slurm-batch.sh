#!/bin/bash
#SBATCH --job-name=transformers
#SBATCH --output=./job.out.%j
#SBATCH --error=./job.err.%j
#SBATCH --mail-user=david.carreto.fidalgo@gmail.com
#SBATCH --mail-type=none
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=0
#SBATCH --time=00:15:00
#SBATCH --constraint=gpu
#SBATCH --chdir=./

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
