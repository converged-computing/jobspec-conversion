#!/bin/bash
#FLUX: --job-name=hairy-fork-0332
#FLUX: -t=39600
#FLUX: --priority=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.5.simg python3 /home/steinba/development/deeprace/deeprace.py train -O n_gpus=4,batch_size=128 -c "k80:4,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/full4/full-resnet32v1-bs128-singularity-ngpu4.tsv resnet32v1
