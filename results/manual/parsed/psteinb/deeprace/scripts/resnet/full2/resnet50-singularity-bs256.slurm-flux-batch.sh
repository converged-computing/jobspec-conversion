#!/bin/bash
#FLUX: --job-name=salted-cat-7380
#FLUX: --queue=gpu2
#FLUX: -t=28800
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.5.simg python3 /home/steinba/development/deeprace/deeprace.py train -O n_gpus=2,batch_size=256 -c "k80:2,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/full2/full-resnet56v1-bs256-singularity-ngpu2.tsv resnet56v1
