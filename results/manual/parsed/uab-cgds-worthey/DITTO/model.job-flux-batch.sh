#!/bin/bash
#FLUX: --job-name=DITTO
#FLUX: --queue=amd-hdr100-res
#FLUX: -t=21600
#FLUX: --urgency=16

module reset
module load Java/13.0.2
module load Anaconda3
/data/project/worthey_lab/tools/nextflow/nextflow-22.10.7/nextflow run ../pipeline.nf \
  --outdir /data/results \
  -work-dir .work_dir/ \
  --build hg38 -c cheaha.config -with-report \
  --sample_sheet .test_data/file_list.txt -resume
