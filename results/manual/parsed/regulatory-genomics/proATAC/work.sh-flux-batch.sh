#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=2
#FLUX: --queue=normal
#FLUX: --urgency=16

conda activate  cutadaptenv
/storage/zhangkaiLab/fanjiaqi/data/PUBATAC_pipline/PUMATAC_dependencies/nextflow/nextflow-21.04.3-all -C atac_preprocess.config run proATAC.nf -entry atac_preprocess -resume
