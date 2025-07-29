#!/bin/bash
#SBATCH --job-name=$2
#SBATCH --output=$2.out
#SBATCH --mail-user=hukaidonghkd@gmail.com
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=7
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH --constraint=gtx1080ti|rtx2080

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
