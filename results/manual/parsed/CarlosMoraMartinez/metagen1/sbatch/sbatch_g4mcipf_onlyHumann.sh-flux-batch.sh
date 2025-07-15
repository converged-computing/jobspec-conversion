#!/bin/bash
#FLUX: --job-name=test_nf
#FLUX: -c=4
#FLUX: --queue=long
#FLUX: --priority=16

module load  Nextflow/23.04.2
module load Anaconda3/5.3.0
nextflow run all.nf -c config/run_samples_g4m_onlyHumann.config -profile conda -resume -with-timeline timeline.html -with-report report.html -with-dag pipeline_dag.html
