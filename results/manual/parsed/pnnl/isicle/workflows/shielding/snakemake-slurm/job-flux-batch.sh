#!/bin/bash
#FLUX: --job-name=isicle_nmr
#FLUX: --queue=shared,slurm,short
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/bashrc
module purge
module load intel/18.0.0
module load gcc/8.1.0
module load python/miniconda3.7
source /share/apps/python/miniconda3.7/etc/profile.d/conda.sh
conda activate isicle
snakemake --unlock
snakemake --cluster 'sbatch --job-name {resources.name} -t {resources.runtime} -p {resources.partition} -N {resources.nodes}' -j 5000 --latency-wait 100 --keep-going --rerun-incomplete
