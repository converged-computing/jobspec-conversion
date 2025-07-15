#!/bin/bash
#FLUX: --job-name=boopy-poodle-0413
#FLUX: --urgency=16

Rscript --vanilla /scratch/aob2x/CompEvoBio_modules/utils/snpCalling/scatter_gather_annotate/vcf2gds.R \
/scratch/aob2x/compBio_SNP_25Sept2023/dest.expevo.PoolSNP.001.50.11Oct2023.norep.ann.vcf.gz
