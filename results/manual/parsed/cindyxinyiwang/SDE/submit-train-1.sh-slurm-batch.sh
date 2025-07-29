#!/bin/bash
#SBATCH --job-name=multlin
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12g
#SBATCH --time=41-16:00:00

export PYTHONPATH='$(pwd)"                                                       '
export CUDA_VISIBLE_DEVICES='1" '

set -e
export PYTHONPATH="$(pwd)"                                                       
export CUDA_VISIBLE_DEVICES="1" 
version=v7_abl_s1
mkdir -p outputs_"$version"
for f in `ls scripts/cfg_"$version"/ | grep -v trans.sh$`; do
  f1=`basename $f .sh`
  if [[ ! -e outputs_"$version"/$f1.started ]]; then
    echo "running $f1"
    touch outputs_"$version"/$f1.started
    hostname
    nvidia-smi
    ./scripts/cfg_"$version"/$f
  else
    echo "already started $f1"
  fi
done
