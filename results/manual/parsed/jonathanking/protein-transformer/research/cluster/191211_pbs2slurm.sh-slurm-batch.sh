#!/bin/bash
#SBATCH --job-name=pt-sweep
#SBATCH --output=research/cluster/slurm/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=10g
#SBATCH --time=28-00:00:00

eval "$(conda shell.bash hook)"
conda activate pytorch-build
cd $SLURM_SUBMIT_DIR
cmd="$(sed -n "${SLURM_ARRAY_TASK_ID}p" research/cluster/191211_test.txt)"
echo $cmd
eval $cmd
exit 0
