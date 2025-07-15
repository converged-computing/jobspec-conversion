#!/bin/bash
#FLUX: --job-name=lovely-destiny-1690
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --priority=16

module load singularity
BIN_VERSION="1.0.0"
WORKING_DIR=/mnt/common/OPEN_DATA/POLARIS_VCF/
mkdir -p $WORKING_DIR
BAM_DIR=/mnt/common/OPEN_DATA/POLARIS_PROCESS/
NSLOTS=$SLURM_CPUS_PER_TASK
Files=(${BAM_DIR}*.sorted.bam)
IFS='/' read -a array <<< ${Files[$SLURM_ARRAY_TASK_ID]}
SAMPLE_BAM=${array[-1]}
IFS='_' read -a array2 <<< "${SAMPLE_BAM}"
SAMPLE=${array2[0]}
GENOME=${array2[1]::-11}
echo $SAMPLE
echo $GENOME
ls $BAM_DIR/$SAMPLE_BAM
if [ $GENOME = "GRCh37" ];
then
        #### GRCh37 ####
        echo "GRCh37 genome"
        BWA_INDEX=/mnt/common/DATABASES/REFERENCES/GRCh37/GENOME/GRCh37-lite.fa
	FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh37/GENOME/
	FASTA_FILE=GRCh37-lite.fa
        SAMPLE_ID=${SAMPLE}_GRCh37
fi
if [ $GENOME = "GRCh38" ];
then
        #### GRCh38 #### 
        echo "GRCh38 genome"
        BWA_INDEX=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/GRCh38-lite.fa
	FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
	FASTA_FILE=GRCh38-lite.fa
        SAMPLE_ID=${SAMPLE}_GRCh38
fi
echo $SAMPLE_ID
echo $BWA_INDEX
singularity run -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${BAM_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${OUTPUT_DIR}":"/output" \
	docker://google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
  --reads="/bamdir/$SAMPLE_BAM" \
  --output_vcf="/output/${SAMPLE_ID}_DeepVariant.vcf.gz" \
  --output_gvcf="/output/${SAMPLE_ID}_DeepVariant.g.vcf.gz" \
  --num_shards=$NSLOTS \
