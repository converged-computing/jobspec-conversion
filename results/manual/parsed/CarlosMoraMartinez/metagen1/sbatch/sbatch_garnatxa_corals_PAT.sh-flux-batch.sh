#!/bin/bash
#FLUX: --job-name=k2pat
#FLUX: -c=4
#FLUX: -t=691200
#FLUX: --urgency=16

module load anaconda #3_2022.10
nextflow run all.nf -c config/run_samples_garnatxa_corals_PAT.config -profile conda -resume -with-report report.html -with-dag pipeline_dag.html
