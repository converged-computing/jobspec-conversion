#!/bin/bash
#SBATCH --output=$1/stdout.txt
#SBATCH --error=$1/stderr.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:1
#SBATCH --mem=15000M
#SBATCH --time=2-14:00:00

cat <<EoF
hostname
echo "$CUDA_VISIBLE_DEVICES"
python3 -u posterior_samples.py ../data/full $1/01 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/02 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/03 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/04 $2 $3 $4 &
python3 -u posterior_samples.py ../data/full $1/05 $2 $3 $4 &
wait
EoF
