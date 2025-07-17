#!/bin/bash
#FLUX: --job-name=misunderstood-lemon-4239
#FLUX: -c=4
#FLUX: -t=504000
#FLUX: --urgency=16

NSLOTS=$SLURM_JOB_CPUS_PER_NODE
PROJECT_DIR=/project/projects/def-wyeth/RICHMOND/SIMULATION/
VCFDIR=/home/richmonp/project/RICHMOND/SIMULATION/STR_SIM/str_simulations/RunAllSTR/
WRITE_DIR=/scratch/richmonp/SIMULATION/
WORKING_DIR=$WRITE_DIR
BWA_INDEX=/project/projects/def-wyeth/GENOME/GSC/GRCh37-lite.fa
GENOME_FASTA=/project/projects/def-wyeth/GENOME/GSC/GRCh37-lite.fa
TMPDIR=$WORKING_DIR'picardtmp/'
mkdir $TMPDIR
Files=(${VCFDIR}*vcf)
IFS='/' read -a array <<< ${Files[$SLURM_ARRAY_TASK_ID]}
SampleVCF=${array[-1]}
IFS='.' read -a array2 <<< "${SampleVCF}"
SAMPLE_ID=${array2[0]}
VCF=${Files[$SLURM_ARRAY_TASK_ID]}
echo $VCF
echo $SampleVCF
echo $SAMPLE_ID
VARSIM_DIR=/project/projects/def-wyeth/RICHMOND/SIMULATION/varsim-0.8.1/varsim_run/
FASTQR1=$WRITE_DIR${SAMPLE_ID}_out/$SAMPLE_ID.R1.fq.gz
FASTQR2=$WRITE_DIR${SAMPLE_ID}_out/$SAMPLE_ID.R2.fq.gz
GANGSTR_REGIONS=/project/projects/def-wyeth/TOOLS/GangSTR-1.4/data/GRCh37_ver10.sorted.bed
STRETCH_REGIONS=/project/projects/def-wyeth/TOOLS/STRetch/reference-data/grch37.simpleRepeat_period1-6_dedup.sorted.bed 
EH_REGIONS=/project/projects/def-wyeth/TOOLS/ExpansionHunter-v3.0.0-rc2-linux_x86_64/variant_catalog/variant_catalog_grch37.json \
module load java
source /project/projects/def-wyeth/TOOLS/SIMULATION_ENVIRONMENT/bin/activate 
cd $VARSIM_DIR
echo "STR Calling Started"
date
cd $WRITE_DIR
module load intel/2016.4
module load intel/2018.3
module load nlopt
module load gsl
module load htslib
module load gcc/7.3.0
echo $SAMPLE_ID
/project/projects/def-wyeth/TOOLS/STRetch/tools/bpipe-0.9.9.5/bin/bpipe run \
	-p input_regions=$STRETCH_REGIONS \
	/project/projects/def-wyeth/TOOLS/STRetch/pipelines/STRetch_wgs_bam_pipeline.groovy \
	$WORKING_DIR$SAMPLE_ID'_dupremoved_realigned.sorted.bam'
/project/projects/def-wyeth/TOOLS/ExpansionHunter-v3.0.0-rc2-linux_x86_64/bin/ExpansionHunter \
	--reads $WORKING_DIR$SAMPLE_ID'_dupremoved_realigned.sorted.bam' \
	--reference $GENOME_FASTA \
	--variant-catalog $EH_REGIONS \
	--output-prefix ${SAMPLE_ID}_EH3
/project/projects/def-wyeth/TOOLS/ExpansionHunter_DeNovo/ExpansionHunterDenovo-v0.6.2 \
	--bam $WORKING_DIR$SAMPLE_ID'_dupremoved_realigned.sorted.bam' \
	--reference  $GENOME_FASTA \
	--output ${SAMPLE_ID}_EHDN.json \
/project/projects/def-wyeth/TOOLS/GangSTR-1.4/bin/GangSTR \
        --bam $WORKING_DIR$SAMPLE_ID'_dupremoved_realigned.sorted.bam' \
        --readlength 150 \
        --coverage 50 \
        --ref $GENOME_FASTA \
        --regions $GANGSTR_REGIONS \
        --out ${SAMPLE_ID}_GangSTR
echo "Finished"
date
