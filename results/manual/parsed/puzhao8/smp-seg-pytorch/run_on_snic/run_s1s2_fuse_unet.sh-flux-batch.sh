#!/bin/bash
#FLUX: --job-name=fuse-unet
#FLUX: -t=604800
#FLUX: --urgency=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
CDC=(0 0.01 0.1 1)
CFG=${CDC[$SLURM_ARRAY_TASK_ID]}
echo "Running simulation $CFG"
echo "singularity exec --nv /cephyr/users/puzhao/Alvis/PyTorch_v1.7.0-py3.sif python main_s1s2_fuse_unet_V1.py model.cross_domain_coef=$CFG"
echo "---------------------------------------------------------------------------------------------------------------"
singularity exec --nv /cephyr/users/puzhao/Alvis/PyTorch_v1.7.0-py3.sif python main_s1s2_fuse_unet_V1.py model.cross_domain_coef=$CFG
rm -rf $SLURM_SUBMIT_DIR/*.log
echo "finish"
