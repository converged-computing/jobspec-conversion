#!/bin/bash
#SBATCH --job-name=smk-parent
#SBATCH --mail-user=thiago.brittoborges@uni-heidelberg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

source ~/bin/snakemake/bin/activate
snakemake -s $1 --unlock
snakemake -s $1 --use-conda --printshellcmds --cluster 'sbatch -p {cluster.partition} --mem {cluster.mem} --out {cluster.out} --error {cluster.out} -c {cluster.cpu}' --cluster-config cluster.yml --jobs 100
