#!/bin/bash
#SBATCH --account=uio
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=500
#SBATCH --time=08:20:00

module load emboss
$JAMG_PATH/bin/prepare_golden_genes_for_predictors.pl -genome $GENOME_PATH.masked -softmasked $GENOME_PATH.softmasked -same_species -intron $MAX_INTRON_LENGTH -cpu $LOCAL_CPUS -norefine -complete -no_single -pasa_gff ./*.assemblies.fasta.transdecoder.gff3 -pasa_peptides ./*.assemblies.fasta.transdecoder.pep -pasa_cds ./*.assemblies.fasta.transdecoder.cds -pasa_genome ./*.assemblies.fasta.transdecoder.genome.gff3 -pasa_assembly ./*.assemblies.fasta
