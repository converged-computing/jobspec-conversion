#!/bin/bash
#FLUX: --job-name=iaf2msa2
#FLUX: --exclusive
#FLUX: --queue=64c512g
#FLUX: --priority=16

root_home=$1
sample_name=$2
hostname
rm -f $root_home/logs/*
source $root_home/.bashrc
cd $root_home/af2pth
conda activate iaf2
bash one_modelinfer_pytorch_jit.sh 8
while true; do
  if [ -f "$root_home/logs/$sample_name.fa.txt" ]; then
    n=`cat $root_home/$sample_name*|grep iaf2_inference_done|wc -l`
  else
    n=0
  fi
  if [ $n -eq 8 ]; then
    break
  fi
  sleep 60
done
echo "iaf2_inference_done"
