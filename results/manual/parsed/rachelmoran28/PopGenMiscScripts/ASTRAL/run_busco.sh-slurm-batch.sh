#!/bin/bash
#SBATCH --job-name=BUSCO
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=62gb
#SBATCH --time=3-08:00:00
#SBATCH --partition=small,amdsmall

module load python/2
src=/home/research/genome/assemblies_configs/
input=/home/research/genome/final_assembly/pilon_final_122418.fa  #genome assembly fasta
lineage=/home/research/genome/assemblies_configs/lineage/actinopterygii_odb9 #Visit http://busco.ezlab.org for lineages - pick one that's closest to your study organism and save somewhere in your h
busco=/home/software/busco/2.0/bin/BUSCO.py #this is the correct path for BUSCO v2.0  
python2 $busco -i $input -o 122418_final_assembly -l $lineage -f -m geno -sp zebrafish
