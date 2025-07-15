#!/bin/bash
#FLUX: --job-name=stanky-malarkey-2938
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/18.10.1-bin
nextflow run -resume -profile pawsey_zeus ./pclust.nf --max_cpus 28 --nomsa_refine --seqs "sequences/proteins.faa" --enrich_seqs "databases/uniclust50_2018_08/uniclust50_2018_08_consensus.fasta" --enrich_msa
