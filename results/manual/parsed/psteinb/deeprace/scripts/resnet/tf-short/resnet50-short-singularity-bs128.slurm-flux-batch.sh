#!/bin/bash
#FLUX: --job-name=boopy-soup-6968
#FLUX: -t=3600
#FLUX: --priority=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.7-plus.simg python3 /home/steinba/development/deeprace/deeprace.py train -R `mktemp -d` -b tf -O batch_size=128 -c "k80:1,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/tf-short/resnet56v1-tf-short-bs128-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet56v1
