#!/bin/bash
#SBATCH --job-name=trna_scan
#SBATCH --output=trna_scan_output.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

tRNAscan-SE -o $1 $2
rule trna_scan:
  input:
    "G_intestinalis.fasta"
  output:
    "G_intestinalis.trna2"
  shell:
    "tRNAscan-SE -o {output} {input}"
