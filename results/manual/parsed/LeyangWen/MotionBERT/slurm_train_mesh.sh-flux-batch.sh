#!/bin/bash
#FLUX: --job-name=MB_train_mesh
#FLUX: -c=4
#FLUX: --queue=spgpu
#FLUX: -t=43200
#FLUX: --urgency=16

my_job_header
module load python3.10-anaconda
module load cuda/11.8.0
module load cudnn/11.8-v8.7.0
module load cupti/11.8.0
module load python/3.10.4
module load pytorch/2.0.1
module list
echo "test"
python train_mesh.py \
--config configs/mesh/MB_train_VEHS_3D.yaml \
--pretrained checkpoint/mesh/FT_Mb_release_MB_ft_pw3d/ \
--selection best_epoch.bin \
--checkpoint checkpoint/mesh/MB_train_VEHSR3 \
--test_set_keyword validate \
--wandb_project "MotionBert_train_mesh" \
--wandb_name "gt2d_17kpts" > output_slurm/train_mesh.out
