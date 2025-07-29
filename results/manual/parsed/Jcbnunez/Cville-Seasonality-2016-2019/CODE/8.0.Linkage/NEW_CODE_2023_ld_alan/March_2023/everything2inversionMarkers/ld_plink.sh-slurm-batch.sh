#!/bin/bash
#FLUX: --job-name=plink
#FLUX: --queue=standard
#FLUX: -t=900
#FLUX: --urgency=16

module load plink/1.90b6.16
cd /scratch/aob2x/ld
plink \
--r2 inter-chr with-freqs yes-really \
--double-id --allow-extra-chr \
--ld-window-r2 0.01 \
--vcf /scratch/aob2x/ld/CM_pops.AllChrs.Whatshap.shapeit.annot.wSNPids.vcf.gz \
--ld-snp-list /project/berglandlab/jcbnunez/Shared_w_Alan/in2lt_ld_47snps_informative_markers.txt \
