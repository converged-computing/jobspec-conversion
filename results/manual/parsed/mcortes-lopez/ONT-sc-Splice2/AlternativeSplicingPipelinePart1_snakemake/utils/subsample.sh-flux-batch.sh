#!/bin/bash
#FLUX: --job-name=TKU4354_subsampling
#FLUX: --queue=pe2
#FLUX: --priority=16

module load seqtk
cd /gpfs/commons/groups/landau_lab/rraviram/Suva_lab_GBM/Splicing_ONT/ONT_Splicing_TKU4354/input_files/1.ONT_fastq/
seqtk sample TKU4354.fastq 5000000 > TKU4354_subsample_5b.fastq
