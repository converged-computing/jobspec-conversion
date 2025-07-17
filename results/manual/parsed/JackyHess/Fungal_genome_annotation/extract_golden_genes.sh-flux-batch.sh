#!/bin/bash
#FLUX: --job-name=swampy-house-0275
#FLUX: -c=10
#FLUX: -t=30000
#FLUX: --urgency=16

module load emboss
$JAMG_PATH/bin/prepare_golden_genes_for_predictors.pl -genome $GENOME_PATH.masked -softmasked $GENOME_PATH.softmasked -same_species -intron $MAX_INTRON_LENGTH -cpu $LOCAL_CPUS -norefine -complete -no_single -pasa_gff ./*.assemblies.fasta.transdecoder.gff3 -pasa_peptides ./*.assemblies.fasta.transdecoder.pep -pasa_cds ./*.assemblies.fasta.transdecoder.cds -pasa_genome ./*.assemblies.fasta.transdecoder.genome.gff3 -pasa_assembly ./*.assemblies.fasta
