#!/bin/bash
#FLUX: --job-name=confused-platanos-1814
#FLUX: -c=40
#FLUX: -t=172800
#FLUX: --priority=16

export ANNOTSV='/mnt/common/Precision/AnnotSV/'

ANNOTATEVARIANTS_INSTALL=/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
SMOOVE_SIF=/mnt/common/Precision/Smoove/smoove_latest.sif
ANNOTSV=/mnt/common/Precision/AnnotSV/
module load singularity
NSLOTS=$SLURM_CPUS_PER_TASK
cd $SLURM_SUBMIT_DIR
WORKING_DIR=/mnt/scratch/Public/TESTING/GenomicsPipelineTest/
mkdir -p $WORKING_DIR
cd $WORKING_DIR
echo "GRCh38 genome"
GENOME=GRCh38
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/1000G/
FASTA_FILE=GRCh38_full_analysis_set_plus_decoy_hla.fa
BAM_DIR=$WORKING_DIR
FAMILY_ID=IBS049
PED=$FAMILY_ID.ped
export ANNOTSV=/mnt/common/Precision/AnnotSV/
singularity run \
	-B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${BAM_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${OUTPUT_DIR}":"/output" \
	$SMOOVE_SIF \
	bash /bamdir/smoove.sh $NSLOTS $FAMILY_ID $FASTA_FILE 
if [ "$GENELIST_BOOL" = true ]; then
	$ANNOTSV/bin/AnnotSV -SVinputFile $WORKING_DIR/results-smoove/${FAMILY_ID}-smoove.genotyped.vcf.gz \
		-genomeBuild $GENOME \
	        -candidateGenesFile $GENELIST \
                -candidateGenesFiltering yes \
	       	-outputFile ${FAMILY_ID}-smoove-annotsv-candidateGenes 
fi
$ANNOTSV/bin/AnnotSV -SVinputFile $WORKING_DIR/results-smoove/${FAMILY_ID}-smoove.genotyped.vcf.gz \
	-genomeBuild $GENOME \
       	-outputFile ${FAMILY_ID}-smoove-annotsv 
