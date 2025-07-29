#!/bin/bash
#SBATCH --job-name=prokka
#SBATCH --output=logs/prokka_%j.log
#SBATCH --mail-user=cbecker@whoi.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=150gb
#SBATCH --time=5-12:00:00
#SBATCH --qos=unlim

prokka FLK2019_assembly2/final.contigs.1000plus.fa --outdir output/prokka3 --prefix BacteriaMG --norrna --notrna --metagenome --cpus 36
