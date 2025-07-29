#!/bin/bash
#SBATCH --job-name=pt-array
#SBATCH --output=../research/cluster/slurm/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=28-00:00:00
#SBATCH --partition=dept_gpu
#SBATCH --constraint=C6&M12

eval "$(conda shell.bash hook)"
conda activate pytorch_c6m12_cuda101
module load cuda/10.1
echo $(which python)
echo "${SLURM_ARRAY_TASK_ID}"
cd $SLURM_SUBMIT_DIR
cmd="$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../research/cluster/200127_pt_array.txt)"
echo $cmd
eval $cmd
exit 0
