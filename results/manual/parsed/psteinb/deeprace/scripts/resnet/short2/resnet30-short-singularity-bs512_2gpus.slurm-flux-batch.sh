#!/bin/bash
#FLUX: --job-name=muffled-lizard-9343
#FLUX: -t=1800
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.5.simg python3 /home/steinba/development/deeprace/deeprace.py train -O n_gpus=2,batch_size=512 -c "k80:2,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/short2/resnet32v1-short-ngpu2-bs512-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet32v1
