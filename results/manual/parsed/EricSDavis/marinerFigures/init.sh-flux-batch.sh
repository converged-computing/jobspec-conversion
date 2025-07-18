#!/bin/bash
#FLUX: --job-name=marinerFigures
#FLUX: --queue=general
#FLUX: -t=864000
#FLUX: --urgency=16

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
