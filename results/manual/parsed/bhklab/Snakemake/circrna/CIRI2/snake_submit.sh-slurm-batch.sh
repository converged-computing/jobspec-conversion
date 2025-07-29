#!/bin/bash
#SBATCH --job-name=snake_ciri_gdsc
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000M
#SBATCH --time=3-00:00:00

source /cluster/home/amammoli/.bashrc
module load python3
output_dir="/cluster/projects/bhklab/Data/ncRNA_detect/circRNA/CIRI2/GDSC"  snakemake -s /cluster/projects/bhklab/Data/ncRNA_detect/circRNA/CIRI2/GDSC/Snakefile --latency-wait 150 -j 300 --cluster 'sbatch -t {params.runtime} --mem={resources.mem_mb} -c {threads} -p {params.partition}'
