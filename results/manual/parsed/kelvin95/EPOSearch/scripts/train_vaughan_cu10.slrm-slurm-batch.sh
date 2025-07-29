#!/bin/bash
#SBATCH --job-name=mtl_nntd
#SBATCH --output=vlogs/job_%A-%a.log
#SBATCH --mail-user=amanjitsk@cs.toronto.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --partition=t4v1,p100,t4v2,rtx6000
#SBATCH --array=0-13

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
