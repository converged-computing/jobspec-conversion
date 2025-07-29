#!/bin/bash
#SBATCH --job-name=GWMC_gtdbtk
#SBATCH --output=/condo/ieg/jianshu/log/jarray.%j.%N.out
#SBATCH --error=/condo/ieg/jianshu/log/jarray.%j.%N.err
#SBATCH --mail-user=jianshuzhao@yahoo.com.
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=240G
#SBATCH --time=08:00:00

module purge
source ~/.bashrc
conda init bash
conda activate gtdbtk
which pplacer
which prodigal
wd=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed
output=/condo/ieg/jianshu/GWMC/12.DAS_allbins_derep_renamed_gtdbtk
/condo/ieg/jianshu/miniconda3/envs/gtdbtk/bin/gtdbtk classify_wf --genome_dir ${wd} --out_dir ${output} --cpus 32 --pplacer_cpus 8 -x fasta
