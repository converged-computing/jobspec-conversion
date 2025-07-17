#!/bin/bash
#FLUX: --job-name=stinky-despacito-7587
#FLUX: -n=6
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module load pytorch/1.13
. ./env.sh
declare -a commands=(
  "train.py --data-dir data/streams/combined --output-dir results/stgcn-xy --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j --k-folds 10 --epochs 20 --xy-data"
  "train.py --data-dir data/streams/combined --output-dir results/stgcn-physical --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j --k-folds 10 --epochs 20 --physical-edges"
  "train.py --data-dir data/streams/combined --output-dir results/stgcn --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j --k-folds 10 --epochs 20"
  "train.py --data-dir data/streams/combined --output-dir results/aagcn --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j --k-folds 10 --epochs 20 --adaptive --attention"
  "train.py --data-dir data/streams/combined --output-dir results/ms-aagcn --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j,b,v,a --k-folds 10 --epochs 20 --adaptive --attention"
  "train.py --data-dir data/streams/combined --output-dir results/ms-aagcn-fts --age-file metadata/combined.csv --learning-rate 0.01 --batch-size 32 --num-workers 16 --streams j,b,v,a --k-folds 10 --epochs 20 --adaptive --attention --concat-features"
)
for cmd in "${commands[@]}"; do
  srun --exclusive -N1 -n1 $cmd &
done
wait
