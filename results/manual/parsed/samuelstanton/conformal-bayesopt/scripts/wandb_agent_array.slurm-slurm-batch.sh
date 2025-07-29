#!/bin/bash
#SBATCH --job-name=conf-bo
#SBATCH --output=/scratch/ss13641/code/remote/conformal-bayesopt/experiments/output/%x_%j.out
#SBATCH --error=/scratch/ss13641/code/remote/conformal-bayesopt/experiments/error/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --array=0-31

export PATH='/ext3/miniconda3/envs/conf-bo-env/bin:${PATH}'

singularity exec --nv --overlay ${SCRATCH}/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "
source /ext3/env.sh
export PATH=/ext3/miniconda3/envs/conf-bo-env/bin:${PATH}
conda activate conf-bo-env
cd /home/ss13641/code/remote/conformal-bayesopt
wandb agent --count 4 samuelstanton/conformal-bayesopt/qy5qbae3
"
