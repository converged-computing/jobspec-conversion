#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:05:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-2

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
