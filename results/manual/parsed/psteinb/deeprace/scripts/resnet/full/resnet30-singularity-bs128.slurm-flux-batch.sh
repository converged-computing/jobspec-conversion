#!/bin/bash
#FLUX: --job-name=tart-pot-3673
#FLUX: -t=18000
#FLUX: --priority=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.3.simg python3 /home/steinba/development/deeprace/deeprace.py train -O batch_size=128 -c "k80:1,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/full/full-resnet32v1-bs128-singularity.tsv resnet32v1
