#!/bin/bash
#SBATCH --job-name=smplx-merge
#SBATCH --account=shdpm0
#SBATCH --output=output_slurm/merge_log.txt
#SBATCH --error=output_slurm/merge_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=50g
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10

my_job_header
conda activate soma3.7
module load clang/2022.1.2
module load gcc/10.3.0
module load gcc/13.2.0
module load intel/2022.1.2
module load boost/1.78.0
module load eigen tbb
module load blender
module list
cd transfer_model
slurm_name=$SLURM_JOB_NAME
slurm_task_id=$SLURM_ARRAY_TASK_ID
python -u merge_output.py \
--batch-moshpp \
--wandb-name "$slurm_name$slurm_task_id" \
--SMPL-batch-store-dir '/scratch/shdpm_root/shdpm0/wenleyan/20240508_temp_store/SMPL_pkl/' \
--batch-id $slurm_task_id \
/scratch/shdpm_root/shdpm0/wenleyan/20240508_temp_store/SMPL_obj_pkl/
