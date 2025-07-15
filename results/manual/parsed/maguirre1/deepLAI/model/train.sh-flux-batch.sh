#!/bin/bash
#FLUX: --job-name=red-truffle-4211
#FLUX: --priority=16

__README="""
A wrapper script for train.py
"""
hn=$(hostname)
if [ $hn = "galangal.stanford.edu" ]; then 
  nvidia-smi
else
  # if not then fiddle around with modules
  ml purge; 
  ml load python/3.6.1 cuda/10.2.89 cudnn/7.6.5; # openmpi/4.0.3
  ml load py-numpy/1.18.1_py36 py-scipy/1.4.1_py36 py-tensorflow/2.1.0_py36;
  # display node info and packages
  nvidia-smi --query-gpu=index,name --format=csv,noheader
  which python3
  ml list
fi
id=${SLURM_ARRAY_TASK_ID:=20}
fs="$( awk -v nr=$id '(NR==nr){print $1}' hparam_to_nparam.tsv )"
nf="$( awk -v nr=$id '(NR==nr){print $2}' hparam_to_nparam.tsv )"
nb="$( awk -v nr=$id '(NR==nr){print $4}' hparam_to_nparam.tsv )"
python3 train.py --out weights/chr20.full.working.${id} --chrom=20 --num-epochs=200 \
  --filter-size=$fs --num-filter=$nf --num-blocks=$nb --batch-size=4 --continue-train
