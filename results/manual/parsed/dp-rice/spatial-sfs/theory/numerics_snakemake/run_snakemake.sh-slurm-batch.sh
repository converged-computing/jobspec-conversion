#!/bin/bash
#SBATCH --job-name=rvsfs
#SBATCH --account=pi-jnovembre
#SBATCH --mail-user=steinerm@uchicago.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=4-00:00:00

module load python
source /software/python-anaconda-2020.02-el7-x86_64/etc/profile.d/conda.sh
conda activate snakemake
snakemake --cores 14 --nolock 
