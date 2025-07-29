#!/bin/bash
#FLUX: --job-name=Demultiplex
#FLUX: -c=10
#FLUX: --queue=highmem_p
#FLUX: -t=3600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source /apps/lmod/lmod/init/zsh
ml SAMtools/1.10-GCC-8.3.0
ml Anaconda3
bamdir=/scratch/jpm73279/comparative_single_cell/02.QC_clustering/zea_mays/doublet_estimation
vcfdir=/scratch/jpm73279/comparative_single_cell/02.QC_clustering/zea_mays/doublet_estimation
vcffile=$vcfdir/B73.Mo17.maize.biallelic.maf05.dp_filt.PHASED.vcf
runDemux(){
	# inputs
	bam=$1
	vcf=$2
	out=$3
	id=$4
	# sample info
	samples=/scratch/jpm73279/comparative_single_cell/02.QC_clustering/zea_mays/doublet_estimation/genotypes.txt
	meta=Zm_Mo17B73_P2_G031_10x.rep1_bc_counts.txt
	# mkdir	
	if [ ! -d $out ]; then
		mkdir $out
	fi
	# subset genotypes
	if [ ! -f $out/$id.INPUT.genotypes.txt ]; then
		if [ $id == "pool21" ] || [ $id == "pool22" ]; then
			awk -F'\t' -v poolID='pool1' '$2==poolID' $samples | cut -f1 - | uniq - > $out/$id.INPUT.genotypes.txt
		else
			awk -F'\t' -v poolID=$id '$2==poolID' $samples | cut -f1 - | uniq - > $out/$id.INPUT.genotypes.txt
		fi
	fi
	# subset barcodes
	if [ ! -f $out/$id.BARCODES.txt ]; then
		awk -F'\t' -v poolID=$id '$2==poolID' $meta | cut -f1 - | uniq - > $out/$id.BARCODES.txt
		sed -i 's/CB:/BC:/' $out/$id.BARCODES.txt
	fi
    conda activate popscle
	# run demuxlet -- change call rate to 0.9
	popscle demuxlet --sam $bam \
		--vcf $vcf \
		--out $out/$id.demuxlet \
		--sm-list $out/$id.INPUT.genotypes.txt \
		--group-list $out/$id.BARCODES.txt \
		--field GT \
		--min-MQ 10 \
		--min-callrate 1
}
export -f runDemux
runDemux Zm_Mo17B73_P2_G031_10x.rep1.mq10.BC.rmdup.mm.renamed_BC_CB.bam $vcffile B73_Mo16_doublet B73_Mo16_doublet
