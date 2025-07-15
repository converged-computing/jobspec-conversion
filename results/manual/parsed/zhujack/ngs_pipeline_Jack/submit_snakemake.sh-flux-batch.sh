#!/bin/bash
#FLUX: --job-name="1s"
#FLUX: --queue="unlimited"
#FLUX: --priority=16

export NGS_PIPELINE='/data/Clinomics/Tools/ngs-pipeline'
export WORK_DIR='`pwd`'
export DATA_DIR='${WORK_DIR}/fastq'
export DATA_DIR_fastq='/data/CCRBioinfo/fastq'

NOW=$(date +"%Y%m%d_%H")
module load python/3.4.3
export NGS_PIPELINE="/data/Clinomics/Tools/ngs-pipeline"
export WORK_DIR=`pwd`
export DATA_DIR="${WORK_DIR}/fastq"
export DATA_DIR_fastq="/data/CCRBioinfo/fastq"
SNAKEFILE=$NGS_PIPELINE/ngs_pipeline.rules
SAM_CONFIG=$WORK_DIR/samplesheet.json
ACT_DIR="/Actionable/"
cd $WORK_DIR
if [ `cat $SAM_CONFIG |/usr/bin/json_verify -c` -ne "JSON is valid" ]; then
    echo "$SAM_CONFIG is not a valid json file"
    exit
fi
if [ ! -d log ];then
    mkdir log
fi
if [ ! -d annovar ]; then 
	mkdir annovar
	touch annovar/AnnotationInput.final.txt
fi
snakemake\
    --directory $WORK_DIR \
    --snakefile $SNAKEFILE \
    --configfile $SAM_CONFIG \
    --jobname '1s{jobid}.{params.rulename}' \
    --rerun-incomplete \
    --nolock \
    -k -p -T \
    -j 3000 \
    --stats ngs_pipeline_${NOW}.stats \
    --cluster "sbatch --mail-type=FAIL -o log/{params.rulename}.%j.o -e log/{params.rulename}.%j.e {params.batch}"\
    >& ngs_pipeline_${NOW}.log
