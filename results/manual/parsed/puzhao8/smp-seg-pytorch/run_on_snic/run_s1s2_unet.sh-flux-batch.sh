#!/bin/bash
#FLUX: --job-name=prepost
#FLUX: --urgency=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
module --ignore-cache load "intel"
PROJECT_DIR=/cephyr/NOBACKUP/groups/snic2021-7-104/puzhao-snic-500G/smp-seg-pytorch
SAT=('S1' 'S2' 'ALOS')
CFG=${SAT[$SLURM_ARRAY_TASK_ID]}
echo "Running simulation $CFG"
echo "singularity exec --nv /cephyr/users/puzhao/Alvis/PyTorch_v1.7.0-py3.sif python main_s1s2_unet.py s1s2_unet=$CFG"
echo "---------------------------------------------------------------------------------------------------------------"
singularity exec --nv /cephyr/users/puzhao/Alvis/PyTorch_v1.7.0-py3.sif python main_s1s2_unet.py 
rm -rf $SLURM_SUBMIT_DIR/*.log
echo "finish"
