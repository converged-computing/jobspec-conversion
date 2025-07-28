#!/bin/bash
#FLUX: --job-name=amber_bench_cuda
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

echo "Running gaussian-test on $SLURM_CPUS_ON_NODE CPU cores"
python InfoVAE_STL10.py
