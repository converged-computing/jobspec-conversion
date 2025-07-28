#!/bin/bash
#FLUX: --job-name=amber_bench_cuda
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Running gaussian-test on $SLURM_CPUS_ON_NODE CPU cores"
python Dropout_Simple_CIFAR6_Berrnoulli_Measurement.py
