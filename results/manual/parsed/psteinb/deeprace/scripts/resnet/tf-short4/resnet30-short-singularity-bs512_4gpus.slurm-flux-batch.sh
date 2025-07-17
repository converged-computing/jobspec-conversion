#!/bin/bash
#FLUX: --job-name=gloopy-caramel-2567
#FLUX: --queue=gpu2
#FLUX: -t=5400
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
TDIR=`mktemp -d`
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.7-plus.simg python3 /home/steinba/development/deeprace/deeprace.py train -R ${TDIR} -b tf -O n_gpus=4,batch_size=512 -c "k80:4,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/tf-short4/resnet32v1-tf-short-ngpu4-bs512-singularity-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.tsv -e 15 resnet32v1
