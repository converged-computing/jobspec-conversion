#!/bin/bash
#SBATCH --job-name=dorefa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-4

echo "$(hostname) $CUDA_VISIBLE_DEVICES"
echo "SLURM_JOBID="$SLURM_JOBID 
echo "SLURM_TASKID="$SLURM_ARRAY_TASK_ID
source /data/sls/r/u/skanda/home/envs/tf2gpu/bin/activate
cd /data/sls/u/meng/skanda/home/thesis/dorefa/real
MODELS=(buffer fcn1 fcn2 cnn lcn)
srun --gres=gpu:1 sharegpu_run.sh ${MODELS[$SLURM_ARRAY_TASK_ID]}
wait
