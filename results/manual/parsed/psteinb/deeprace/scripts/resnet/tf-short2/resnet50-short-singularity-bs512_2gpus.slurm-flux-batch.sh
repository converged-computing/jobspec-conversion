#!/bin/bash
#FLUX: --job-name=phat-bicycle-4899
#FLUX: --queue=gpu2
#FLUX: -t=3600
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
TDIR=`mktemp -d`
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.7-plus.simg python3 /home/steinba/development/deeprace/deeprace.py train -R ${TDIR} -b tf -O n_gpus=2,batch_size=512 -c "k80:2,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/tf-short2/resnet56v1-tf-short-ngpu2-bs512-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet56v1
