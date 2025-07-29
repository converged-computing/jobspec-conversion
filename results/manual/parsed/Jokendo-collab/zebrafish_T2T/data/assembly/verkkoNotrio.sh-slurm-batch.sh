#!/bin/bash
#SBATCH --job-name=fish6_verkko
#SBATCH --mail-user=javan.okendo@nih.gov
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=180g
#SBATCH --time=10-00:00:00
#SBATCH --partition=norm

module load verkko/1.3.1
module load snakemake/7.7.0
module load R/4.2.0
module load bedtools/2.30.0
module load samtools/1.9
module load gcc/9.2.0
module load python/3.7
cd /data/okendojo/zebrafish/data/fish6/asm
hifi=/data/okendojo/zebrafish/data/fish6/hifi/*.gz
ontData=/data/okendojo/zebrafish/data/fish6/ontData/*.gz
verkko -d fish6t2t --hifi ${hifi} --nano ${ontData} --slurm --graphaligner --mbg 
