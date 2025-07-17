#!/bin/bash
#FLUX: --job-name=red-ricecake-9699
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --urgency=16

mkdir -p /tmp/skoroki/czsl/data
cp -r "/ibex/scratch/skoroki/datasets/${dataset}_feats" /tmp/skoroki/czsl/data
echo "`gpustat`"
echo "`nvidia-smi`"
echo "CLI args: $cli_args"
cd /home/skoroki/zslll-master
firelab start configs/zsl.yml $cli_args
