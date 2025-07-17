#!/bin/bash
#FLUX: --job-name=smplx-obj-write
#FLUX: -c=2
#FLUX: --queue=spgpu
#FLUX: -t=43200
#FLUX: --urgency=16

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
cd transfer_model
python -u write_obj.py \
--model-folder ../models/ \
--motion-file /nfs/turbo/coe-shdpm/leyang/VEHS-7M/Mesh/SOMA_SMPLX_pkl/ \
--output-folder /nfs/turbo/coe-shdpm/leyang/VEHS-7M/Mesh/SMPLX_obj/ \
--model-type smplx \
--batch-moshpp \
--batch-id $slurm_task_id
