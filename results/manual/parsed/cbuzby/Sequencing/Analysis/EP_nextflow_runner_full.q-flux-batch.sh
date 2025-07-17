#!/bin/bash
#FLUX: --job-name=nf_full
#FLUX: -t=360000
#FLUX: --urgency=16

module purge
module load nextflow/20.10.0
cd /scratch/yp19/sequencing_analysis/VariantCall_Full/
nextflow run /scratch/yp19/sequencing_analysis/nf_scripts/filepair_input_pipeline.nf -resume -params-file /scratch/yp19/sequencing_analysis/nf_scripts/param_file.yaml -with-timeline timeline_full.html -with-report report_full.html
