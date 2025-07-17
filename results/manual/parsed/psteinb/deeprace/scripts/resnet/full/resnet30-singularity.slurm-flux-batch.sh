#!/bin/bash
#FLUX: --job-name=conspicuous-house-7507
#FLUX: --queue=gpu2
#FLUX: -t=36000
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load singularity/2.4.2
singularity exec -B $PWD:/home/steinba/deeprace --nv /scratch/steinba/tf1.3.simg python3 /home/steinba/development/deeprace/deeprace.py train -c "k80:1,fs:nfs,singularity:lustre" -t /home/steinba/development/deeprace/scripts/full/full-resnet32v1-singularity.tsv resnet32v1
