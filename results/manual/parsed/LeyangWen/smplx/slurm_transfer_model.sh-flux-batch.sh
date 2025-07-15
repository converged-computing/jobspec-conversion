#!/bin/bash
#FLUX: --job-name=transfer-model
#FLUX: -c=4
#FLUX: --queue=spgpu
#FLUX: -t=144000
#FLUX: --priority=16

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
