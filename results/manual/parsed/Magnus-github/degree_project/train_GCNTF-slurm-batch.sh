#!/bin/bash
#SBATCH --output=/Midgard/home/%u/thesis/degree_project/slurmlogs/%J_slurm.out
#SBATCH --error=/Midgard/home/%u/thesis/degree_project/slurmlogs/%J_slurm.err
#SBATCH --mail-user=tibbe@kth.se
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=galadriel|eowyn

echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate /Midgard/home/tibbe/mambaforge/envs/openpose
python main.py --config ${CONFIG} --project ${PROJECT_NAME}
