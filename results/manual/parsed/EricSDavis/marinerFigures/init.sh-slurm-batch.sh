#!/bin/bash
#SBATCH --job-name=marinerFigures
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=10-00:00:00
#SBATCH --partition=general

set -e
mkdir -p logs
module load python/3.7.14
python3 -m venv env &&\
  source env/bin/activate &&\
  pip3 install snakemake
snakemake \
  --cluster "sbatch -J {rule} \
                    --mem={resources.mem} \
                    -t {resources.runtime} \
                    -o logs/{rule}_%j.out \
                    -e logs/{rule}_%j.out" \
  -j 100 \
  --rerun-incomplete
