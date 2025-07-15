#!/bin/bash
#FLUX: --job-name=ornery-banana-5552
#FLUX: -t=3600
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.3.simg python3 /home/steinba/development/deeprace/deeprace.py train -O batch_size=256 -c "k80:1,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/short/resnet56v1-short-bs256-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet56v1
