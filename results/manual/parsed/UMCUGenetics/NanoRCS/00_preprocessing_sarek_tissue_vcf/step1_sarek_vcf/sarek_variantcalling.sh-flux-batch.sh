#!/bin/bash
#FLUX: --job-name=JOBNAME
#FLUX: -t=172800
#FLUX: --urgency=16

OUTPUT=/path/to/output/folder/NanoRCS/output/processed_data/00_preprocessing_sarek_tissue_vcf/variant_calling/SAMPLES
if [[ ! -d $OUTPUT ]]; then
	mkdir $OUTPUT
fi
chmod -R 775 $OUTPUT
cd $OUTPUT
mkdir log
if ! { [ -f 'workflow.running' ] || [ -f 'workflow.done' ] || [ -f 'workflow.failed' ]; }; then
touch workflow.running
sbatch <<EOT 
23.04.2.5870/nextflow run /path/to/pipelines/nfcore/sarek/sarek_v3.1.2/main.nf \
-profile slurm \
--custom_config_base /path/to/pipelines/nfcore/sarek/sarek_v3.1.2/conf/umcu_custom/ \
-c custom.config \
--genome hs37d5.GRCh37 \
--input /path/to/csv/recalibrated.csv \
--step variant_calling \
--tools freebayes,haplotypecaller,strelka,manta,tiddit,controlfreec,mutect2,cnvkit,snpeff \
--cf_window 1000 \
--outdir ${OUTPUT} \
--account ubec \
-w ${OUTPUT}/work \
-resume
if [ 0 -eq 0 ]; then
    echo 'Nextflow done.'
    echo 'NFcore workflow completed successfully.'
    rm workflow.running
    touch workflow.done
    exit 0
else
    echo 'Nextflow failed'
    rm workflow.running
    touch workflow.failed
    exit 1
fi
EOT
else
echo Workflow job not submitted, please check $OUTPUT for log files.
fi
