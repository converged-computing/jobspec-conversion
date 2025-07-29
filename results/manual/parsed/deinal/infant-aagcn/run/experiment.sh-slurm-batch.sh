#!/bin/bash
#SBATCH --output=slurm/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=08:00:00

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
