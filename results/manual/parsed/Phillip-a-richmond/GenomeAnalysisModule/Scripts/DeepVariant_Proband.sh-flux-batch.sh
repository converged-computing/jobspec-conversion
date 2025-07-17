#!/bin/bash
#FLUX: --job-name=faux-puppy-3087
#FLUX: -c=10
#FLUX: --queue=defq
#FLUX: -t=172800
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='$PWD'

module load singularity
source  /mnt/common/Precision/Miniconda3/opt/miniconda3/etc/profile.d/conda.sh
conda  activate  GenomeAnalysis
unset $PYTHONPATH
export SINGULARITY_CACHEDIR=$PWD
DeepVariantSIF=/mnt/common/Precision/DeepVariant/deepvariant_1.2.0.sif
WORKING_DIR=/mnt/scratch/Public/TRAINING/GenomeAnalysisModule/StudentSpaces/Sherlock/
cd $WORKING_DIR 
SAMPLE_ID=Proband
SAMPLE_BAM=$SAMPLE_ID.sorted.bam
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
FASTA_FILE=GRCh38-lite.fa
OUTPUT_DIR=$WORKING_DIR/${SAMPLE_ID}_DeepVariant
mkdir -p $OUTPUT_DIR
singularity exec -c -e \
	-B "${WORKING_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${WORKING_DIR}":"/output" \
	-W $WORKING_DIR \
	$DeepVariantSIF \
  /opt/deepvariant/bin/run_deepvariant \
    --intermediate_results_dir="/output/intermediate_results_dir" \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
  --reads="/bamdir/$SAMPLE_BAM" \
  --output_vcf="/output/${SAMPLE_ID}_DeepVariant.vcf.gz" \
  --regions "19:1,200,000-1,300,000" \
  --num_shards=$SLURM_CPUS_PER_TASK 
