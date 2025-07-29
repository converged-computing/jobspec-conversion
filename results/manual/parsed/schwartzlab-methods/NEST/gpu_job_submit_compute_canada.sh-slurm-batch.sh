#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --account=dummy_group
#SBATCH --output=V1_human_lymph_log-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=63500M
#SBATCH --time=1-00:00:00

echo "Current working directory: `pwd`"
echo "Starting run at: `date`"
echo ""
echo "Job Array ID / Job ID: $SLURM_ARRAY_JOB_ID / $SLURM_JOB_ID"
echo "This is job $SLURM_ARRAY_TASK_ID out of $SLURM_ARRAY_TASK_COUNT jobs."
echo ""
source /home/[user_name]/ENV/bin/activate
module load python/3.10
echo 'Available gpu: '
nvidia-smi
cd /project/[group_name]/[user_name]/NEST
echo 'Running NEST'
nest run --data_name='V1_Human_Lymph_Node_spatial' --num_epoch 80000 --manual_seed='yes' --seed=1 --model_name 'NEST_V1_Human_Lymph_Node_spatial' --run_id=1 
echo "Job finished with exit code $? at: `date`"
