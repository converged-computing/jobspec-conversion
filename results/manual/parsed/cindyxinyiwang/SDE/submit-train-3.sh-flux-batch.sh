#!/bin/bash
#FLUX: --job-name="multlin"
#FLUX: -t=3600000
#FLUX: --priority=16

export PYTHONPATH='$(pwd)"                                                       '
export CUDA_VISIBLE_DEVICES='3" '

set -e
export PYTHONPATH="$(pwd)"                                                       
export CUDA_VISIBLE_DEVICES="3" 
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
