#!/bin/bash
#SBATCH --job-name=crawl_data
#SBATCH --account=loop
#SBATCH --output=log/%J.o
#SBATCH --error=log/%J.e
#SBATCH --mail-user=zxyvse@rit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=4-06:05:03

mkdir -p log
spack load py-urllib3
spack load py-pandas
python3 parse.py
