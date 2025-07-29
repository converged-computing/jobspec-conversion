#!/bin/bash
#SBATCH --job-name=transfer-model
#SBATCH --account=shdpm0
#SBATCH --output=output_slurm/transfer-model_log.txt
#SBATCH --error=output_slurm/transfer-model_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=10g
#SBATCH --time=1-16:00:00
#SBATCH --partition=spgpu
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
slurm_name=$SLURM_JOB_NAME
slurm_task_id=$SLURM_ARRAY_TASK_ID
python -m transfer_model \
--exp-cfg config_files/smplx2smpl.yaml \
--batch-moshpp \
--batch-id $slurm_task_id \
--overwrite-input-obj-folder /nfs/turbo/coe-shdpm/leyang/VEHS-7M/Mesh/SMPLX_obj/ \
--overwrite-output-folder /scratch/shdpm_root/shdpm0/wenleyan/20240508_temp_store/SMPL_obj_pkl/ \
--wandb-name "$slurm_name$slurm_task_id" \
