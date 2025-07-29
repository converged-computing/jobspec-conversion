#!/bin/bash
#FLUX: --job-name=$2
#FLUX: -n=7
#FLUX: --queue=gpu
#FLUX: --urgency=16

if [ -e $2.out ]; then
  >&2 echo $2.out File already exists. Protectively reject submitting job
  exit 1
fi
touch $2.out
cat << HERE | sbatch
module load singularity || true
set -xe
singularity exec --nv /home/hpc/hpcguest4/sifs/keras-230704.sif python3 $1 ${@:3}
HERE
