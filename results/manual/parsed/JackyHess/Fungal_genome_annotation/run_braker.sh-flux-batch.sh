#!/bin/bash
#FLUX: --job-name=spicy-itch-4853
#FLUX: -c=16
#FLUX: --urgency=16

braker.pl --overwrite --fungus --cores 16 --gff3 --genome=$GENOME_PATH.softmasked --species $GENOME_NAME.BRAK --bam=../../RNAseq-data/$GENOME_NAME.alignment.sorted.bam --AUGUSTUS_CONFIG_PATH=/usit/abel/u1/jacqueh/Software/augustus-3.2.1/config --GENEMARK_PATH=/usit/abel/u1/jacqueh/Software/gm_et_linux_64/gmes_petap --BAMTOOLS_PATH=/usit/abel/u1/jacqueh/Software/bamtools/bin --SAMTOOLS_PATH=/cluster/software/VERSIONS/samtools/1.2/bin --softmasking on --useexisting
genemark_gtf2gff3 braker/$GENOME_NAME.BRAK/GeneMark-ET/genemark.gtf > genemark.gff3
$JAMG_PATH/3rd_party/evidencemodeler/EvmUtils/misc/augustus_to_GFF3.pl braker/$GENOME_NAME.BRAK/augustus.gff3 > augustus_EVM.gff3
