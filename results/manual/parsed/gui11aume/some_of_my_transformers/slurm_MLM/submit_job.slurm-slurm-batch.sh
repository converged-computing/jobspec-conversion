#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --account=def-gfilion
#SBATCH --output=/scratch/g/gfilion/gfilion/output_file_%j.out
#SBATCH --error=/scratch/g/gfilion/gfilion/error_file_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1-00:00:00
#SBATCH --partition=compute_full_node
#SBATCH --constraint=ntasks-per-node=4

export CUBLAS_WORKSPACE_CONFIG=':4096:2'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module --ignore_cache load cuda/11.4.4
module --ignore_cache load anaconda3
source activate pytorch
cd /scratch/g/gfilion/gfilion
export CUBLAS_WORKSPACE_CONFIG=:4096:2
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python ./pretrain_MLM.py majestic_tokenizer.json flat_claims.txt.gz trained.pt
