#!/bin/bash
#FLUX: --job-name=mtl_nntd
#FLUX: -c=8
#FLUX: --queue=t4v1,p100,t4v2,rtx6000
#FLUX: --urgency=16

echo Running on $(hostname)
(while true; do
  nvidia-smi
  sleep 120
done) &
DSET="${1:-celeba}"
ARCH="${2:-lenet}"
NUM_RUNS="${3:-1}"
A=(epo
  graddrop
  graddrop_random
  graddrop_deterministic
  gradnorm
  gradvacc
  gradortho
  gradalign
  individual
  itmtl
  linscalar
  mgda
  pcgrad
  pmtl)
cd /h/amanjitsk/projects/EPOSearch/multiMNIST
for _ in $(seq $NUM_RUNS); do
  poetry run python train.py \
    --dset="$DSET" --arch="$ARCH" \
    --seed="$RANDOM" --solver="${A[$SLURM_ARRAY_TASK_ID]}" \
    --outdir=/checkpoint/amanjitsk/runs
done
