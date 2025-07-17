#!/bin/bash
#FLUX: --job-name=cowy-fudge-3713
#FLUX: --queue=gpu2
#FLUX: -t=2700
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /home/steinba/software/singularity/tf1.3.simg python3 /home/steinba/development/deeprace/deeprace.py train -c "k80:1,fs:nfs,singularity:nfs" -t /home/steinba/development/deeprace/scripts/short/resnet32v1-short-singularity-nfs-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet32v1
