#!/bin/bash
#SBATCH --job-name=isicle_nmr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00

source /etc/bashrc
module purge
module load intel/18.0.0
module load gcc/8.1.0
module load python/miniconda3.7
source /share/apps/python/miniconda3.7/etc/profile.d/conda.sh
conda activate isicle
snakemake --unlock
snakemake --cluster 'sbatch --job-name {resources.name} -t {resources.runtime} -p {resources.partition} -N {resources.nodes}' -j 5000 --latency-wait 100 --keep-going --rerun-incomplete
