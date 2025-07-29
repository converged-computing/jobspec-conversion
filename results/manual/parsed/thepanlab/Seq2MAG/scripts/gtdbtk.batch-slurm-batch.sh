#!/bin/bash
#SBATCH --job-name=GTDB
#SBATCH --output=GTDB_%J_stdout.txt
#SBATCH --error=GTDB_%J_stderr.txt
#SBATCH --mail-user=lizhang12@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=180G
#SBATCH --time=8-08:00:00
#SBATCH --partition=omicsbio
#SBATCH --chdir=/work/TEDDY/binning/GTDB/
#SBATCH --nodelist=c660

module load Python/3.6.3-intel-2016a
module load HMMER/3.2.1-foss-2018b
module load pplacer/1.1.alpha19
gtdbtk classify_wf --batch TEDDY_MAGs --out_dir TEDDY_GTDB --cpus 40 
