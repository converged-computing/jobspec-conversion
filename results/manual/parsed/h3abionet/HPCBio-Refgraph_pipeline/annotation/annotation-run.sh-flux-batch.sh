#!/bin/bash
#FLUX: --job-name=annotation
#FLUX: --urgency=16

cd /home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021
module load nextflow/21.04.1-Java-1.8.0_152
nextflow run HPCBio-Refgraph_pipeline/annotation.nf \
-c HPCBio-Refgraph_pipeline/annotation-config.conf \
-qs 3 -resume \
-with-report nextflow_reports/annotation_nf_report.html \
-with-timeline nextflow_reports/annotation_nf_timeline.html \
-with-trace nextflow_reports/annotation_nf_trace.txt
 #   then 
  #      echo "The filtering has not been done correctly. Please check your blastncontam script"
   # fi
