#!/bin/bash
#SBATCH --job-name=iaf2msa1
#SBATCH --output=preproc_onenode_out.txt
#SBATCH --error=preproc_onenode_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=64c512g
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

root_home=$1 # root of IO paths
sample_name=$2 # sample prefix
hostname
rm -f $root_home/logs/*
source $root_home/.bashrc
cd $root_home/af2pth
conda activate iaf2
bash multi_preproc.sh 8
while true; do
  if [ -f "$root_home/logs/${sample_name}.fa.txt" ]; then
    n=`cat $root_home/${sample_name}*|grep iaf2_preproc_done|wc -l`
  else
    n=0
  fi
  if [ $n -eq 8 ]; then
    break
  fi
  sleep 60
done
echo "iaf2_preproc_done"
