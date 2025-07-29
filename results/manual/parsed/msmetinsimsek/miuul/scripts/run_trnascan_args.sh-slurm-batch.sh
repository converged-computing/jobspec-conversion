#!/bin/bash
#FLUX: --job-name=trna_scan
#FLUX: --urgency=16

tRNAscan-SE -o $1 $2
rule trna_scan:
  input:
    "G_intestinalis.fasta"
  output:
    "G_intestinalis.trna2"
  shell:
    "tRNAscan-SE -o {output} {input}"
