#!/bin/bash
#SBATCH --mail-user={kara_moser@med.unc.edu}
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=7Gb
#SBATCH --time=4-00:00:00

module load samtools
snakemake -s do-alignment-ngmlr.py --cluster "sbatch -n5 -t 4-00:00:00 --mem 7Gb " -j 8
