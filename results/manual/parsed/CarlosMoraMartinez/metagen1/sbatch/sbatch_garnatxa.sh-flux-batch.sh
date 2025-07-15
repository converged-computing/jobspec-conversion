#!/bin/bash
#FLUX: --job-name=test_nf
#FLUX: -c=4
#FLUX: --urgency=16

module load anaconda #3_2022.10
nextflow run all.nf -c config/run_samples_garnatxa.config -profile conda -resume -with-timeline timeline.html -with-report report.html -with-dag pipeline_dag.html
