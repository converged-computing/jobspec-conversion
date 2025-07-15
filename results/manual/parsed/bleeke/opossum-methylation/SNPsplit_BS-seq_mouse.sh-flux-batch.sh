#!/bin/bash
#FLUX: --job-name=SNPsplit
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --urgency=16

echo "IT HAS BEGUN"
date
LIBNUM=${SLURM_ARRAY_TASK_ID}
echo "we are working on library number" "$LIBNUM"
BAMDIR=/camp/lab/turnerj/working/Bryony/mouse_adult_xci/allele_specific/data/bs-seq/bams # where the mapped files to be split are
SNPDIR=/camp/lab/turnerj/working/Bryony/mouse_adult_xci/allele_specific/data/n_mask_genome # where the list of SNPs is
OUTDIR=/camp/lab/turnerj/working/Bryony/mouse_adult_xci/allele_specific/data/bs-seq/bams/split_bams
ml purge
ml Anaconda2
source activate SNPsplit
echo "loaded modules are:"
ml
echo "running SNPsplit"
SNPsplit --bisulfite --conflicting -o $OUTDIR --snp_file $SNPDIR/all_SNPs_SPRET_EiJ_GRCm38.txt.gz $BAMDIR/LEE73A${LIBNUM}_*.bam
echo "IT HAS FINISHED"
date
