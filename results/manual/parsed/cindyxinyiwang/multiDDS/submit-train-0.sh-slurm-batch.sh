#!/bin/bash
#SBATCH --job-name=multlin
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12g
#SBATCH --time=41-16:00:00

set -e
version=single
mkdir -p checkpoints/"$version"
for f in `ls job_scripts/"$version"/`; do
  f1=`basename $f .sh`
  echo $f1
  if [[ ! -e checkpoints/"$version"/$f1.started ]]; then
    echo "running $f1"
    touch checkpoints/"$version"/$f1.started
    hostname
    nvidia-smi
    ./job_scripts/"$version"/$f $1
  else
    echo "already started $f1"
  fi
done
