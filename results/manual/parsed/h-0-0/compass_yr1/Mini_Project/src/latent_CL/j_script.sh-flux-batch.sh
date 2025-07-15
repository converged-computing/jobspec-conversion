#!/bin/bash
#FLUX: --job-name=fugly-parsnip-3321
#FLUX: --queue=test
#FLUX: -t=300
#FLUX: --priority=16

export EXE='/bin/hostname'

export EXE=/bin/hostname
cd "${SLURM_SUBMIT_DIR}"
LS=('RN50_clip' 'resnet18')
${EXE}
echo JOB ID: ${SLURM_JOBID}
echo SLURM ARRAY ID: ${SLURM_ARRAY_TASK_ID}
echo Working Directory: $(pwd)
echo Start Time: $(date)
source ~/tmp/mypyenvb/bin/activate
python dataset_encoder.py --pretrained_encoder 1 --regime latent_ER --dataset_name CIFAR100 --dataset_encoder_name ${LS[${SLURM_ARRAY_TASK_ID}]}
echo End Time: $(date)
