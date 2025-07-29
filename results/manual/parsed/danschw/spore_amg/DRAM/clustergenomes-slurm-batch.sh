#!/bin/bash
#SBATCH --mail-user=jrodram@colostate.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50gb
#SBATCH --time=9-02:00:00
#SBATCH --partition=wrighton-hi

cd /home/projects/Sporulation_AMG/hmp/vMAG/
Cluster_genomes_5.1.pl -f /home/projects/Sporulation_AMG/hmp/vMAG/hmp_ge10kb_sporAMG_viruses.fasta -c 85 -i 95 -t 10
