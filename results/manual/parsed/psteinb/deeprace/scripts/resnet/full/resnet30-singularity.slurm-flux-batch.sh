#!/bin/bash
#FLUX: --job-name=reclusive-peanut-4943
#FLUX: -t=36000
#FLUX: --priority=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.3.simg python3 /home/steinba/development/deeprace/deeprace.py train -c "k80:1,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/full/full-resnet32v1-singularity.tsv resnet32v1
