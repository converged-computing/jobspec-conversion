#!/bin/bash
#FLUX: --job-name=delicious-rabbit-4324
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --priority=16

module load singularity
ANNOTATEVARIANTS_INSTALL=annotatevariants_install
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
PARLIAMENT2_SIF=/mnt/common/Precision/Parliament2/parliament2_v0.1.11-0-gb492db6d.sif
SAMPLE=sample_id
INBAM=${SAMPLE}_GRCh38.dupremoved.sorted.bam
WORKING_DIR=/mnt/scratch/Precision/EPGEN/PROCESS/EPGEN012_PAR/
INPUT_DIR=${WORKING_DIR}/Parliament2-${SAMPLE}/Input
OUTPUT_DIR=${WORKING_DIR}/Parliament2-${SAMPLE}/Output
TMP_DIR=$INPUT_DIR/tmp
mkdir -p ${WORKING_DIR}/Parliament2-${SAMPLE}/
mkdir -p $OUTPUT_DIR
mkdir -p $INPUT_DIR
mkdir -p $TMP_DIR
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/1000G/
FASTA_FILE=GRCh38_full_analysis_set_plus_decoy_hla.fa
if [ ! -f $INPUT_DIR/$FASTA_FILE ]; then
	cp $FASTA_DIR/$FASTA_FILE $INPUT_DIR/$FASTA_FILE
	cp $FASTA_DIR/$FASTA_FILE.fai $INPUT_DIR/$FASTA_FILE.fai
fi
if [ ! -f $INPUT_DIR/$INBAM ]; then
	cp $WORKING_DIR/$INBAM $INPUT_DIR
	cp $WORKING_DIR/$INBAM.bai $INPUT_DIR
fi
cd $INPUT_DIR
LANG= singularity run --workdir $TMP_DIR \
        -B ${INPUT_DIR}:/home/dnanexus/in:rw \
        -B ${OUTPUT_DIR}:/home/dnanexus/out:rw \
	$PARLIAMENT2_SIF \
	--bam $INBAM \
	--bai $INBAM.bai \
	-r $FASTA_FILE \
	--fai $FASTA_FILE.fai \
	--prefix $SAMPLE \
	--breakdancer --breakseq --manta --cnvnator --lumpy --genotype --svviz --delly_deletion --delly_insertion --delly_inversion --delly_duplication 
