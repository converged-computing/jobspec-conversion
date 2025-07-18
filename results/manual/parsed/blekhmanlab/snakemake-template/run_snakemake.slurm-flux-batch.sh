#!/bin/bash
#FLUX: --job-name=buttery-latke-6759
#FLUX: --queue=blekhman
#FLUX: -t=162000
#FLUX: --urgency=16

module load python
if [ ! -d "./venv" ]; then
    python -m venv venv
fi
source venv/bin/activate
if [ ! -f "./venv/bin/snakemake" ]; then
    pip install --upgrade pip
    pip install -r requirements.txt
fi
snakemake --jobs 25 --slurm --default-resources slurm_account=blekhman slurm_partition=blekhman
