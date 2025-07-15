#!/bin/bash
#FLUX: --job-name="bowtie2-index" #name of the job submitted
#FLUX: --priority=16

module load bowtie2/2.3.4
ref_file="/project/genolabswheatphg/v1_refseq/Clay_splitchroms_reference/161010_Chinese_Spring_v1.0_pseudomolecules_parts.fasta"
nthreads=40
date
ind_name="${ref_file%.*}"
bowtie2-build --threads $nthreads "${ref_file}" "${ind_name}"
date
