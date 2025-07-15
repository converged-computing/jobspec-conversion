#!/bin/bash
#FLUX: --job-name=bloated-kitty-8772
#FLUX: -c=10
#FLUX: -t=309600
#FLUX: --priority=16

module load singularity
BIN_VERSION="1.1.0"
ANNOTATEVARIANTS_INSTALL=/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
NSLOTS=$SLURM_CPUS_PER_TASK
WORKING_DIR=/mnt/common/OPEN_DATA/BuildControlCohort/WGS/
mkdir -p $WORKING_DIR
BAM_DIR=/mnt/common/OPEN_DATA/BuildControlCohort/WGS/
Files=(${BAM_DIR}*cram)
IFS='/' read -a array <<< ${Files[$SLURM_ARRAY_TASK_ID]}
SampleBam=${array[-1]}
IFS='.' read -a array2 <<< "${SampleBam}"
SAMPLE=${array2[0]}
echo $SAMPLE
echo "${SAMPLE}.final.cram"
BAM=$BAM_DIR/$SAMPLE.final.cram
ls $BAM
echo "GRCh38 genome"
GENOME=GRCh38
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/1000G/
FASTA_FILE=GRCh38_full_analysis_set_plus_decoy_hla.fa 
SEQ_TYPE=WGS
BAM_DIR=$WORKING_DIR
TMP_DIR=$WORKING_DIR/tmp
mkdir -p $TMP_DIR
TARGET=/mnt/common/OPEN_DATA/BuildControlCohort/FLNA.bed
samtools view \
	--write-index \
	$BAM \
	-@ $NSLOTS \
	-T $FASTA_DIR/$FASTA_FILE \
	-C \
	-L $TARGET \
	-o ${SAMPLE}_FLNA-target-region.cram
