#!/bin/bash
#FLUX: --job-name=cowy-caramel-1325
#FLUX: --urgency=16

VCF=/panfs/roc/groups/9/morrellp/shared/Projects/Mutant_Barley/longranger_morex_v2/combined_mutated/Filtered/deletions/M01_singletons_only-scored_DEL_gte75Sup.vcf
OUT_DIR=/panfs/roc/groups/9/morrellp/pmorrell/Workshop/Barley_Mutants
IMPORTANT=/panfs/roc/groups/9/morrellp/shared/References/Reference_Sequences/Barley/Morex_v2/gene_annotation/Barley_Morex_V2_gene_annotation_PGSB.all.parts.sorted.bed
ANNOTATE=/panfs/roc/groups/9/morrellp/pmorrell/Workshop/Barley_Morex_V2_pseudomolecules_parts_missing.bed.gz
cd ${OUT_DIR} || exit
samplot vcf \
--vcf ${VCF} \
--sample_ids Morex_10X Morex_Nanopore M01_Nanopore M01_10X \
--out-dir ${OUT_DIR}/ \
--output_type png \
--important_regions ${IMPORTANT} \
-A ${ANNOTATE} \
--bams /panfs/roc/groups/9/morrellp/shared/Projects/WBDC_inversions/nanopore/Morex/Morex_run1_to_run14/Morex_nanopore_1_14_V2_parts/Morex_1_14_align_V2_sorted_parts.bam \
/panfs/roc/groups/9/morrellp/shared/Projects/WBDC_inversions/nanopore/Morex/Morex_run1_to_run14/Morex_nanopore_1_14_V2_parts/Morex_1_14_align_V2_sorted_parts.bam \
/panfs/roc/groups/9/morrellp/shared/Datasets/Alignments/nanopore_mutated_barley/sam_processing/M01-3-3-12-41_run1-3.bam \
/panfs/roc/groups/9/morrellp/shared/Projects/Mutant_Barley/longranger_morex_v2/M01-3-3/M01-3-3_phased_possorted_bam.bam \
> samplot_commands.sh
