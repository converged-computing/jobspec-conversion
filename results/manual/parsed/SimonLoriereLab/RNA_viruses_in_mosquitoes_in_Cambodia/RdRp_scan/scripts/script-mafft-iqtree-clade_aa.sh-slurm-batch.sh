#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=47
#SBATCH --mem=250000
#SBATCH --partition=geva

module load fasta ruby
module load mafft/7.467
module load goalign/0.3.1
module load IQ-TREE/2.0.6
module load FastTree/2.1.11
