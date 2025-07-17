#!/bin/bash
#FLUX: --job-name=hairy-itch-0583
#FLUX: --queue=gpu2
#FLUX: -t=7200
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.5.simg python3 /home/steinba/development/deeprace/deeprace.py train -O n_gpus=4,batch_size=128 -c "k80:4,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/short4/resnet56v1-short-ngpu4-bs128-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet56v1
