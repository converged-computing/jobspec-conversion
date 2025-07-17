#!/bin/bash
#FLUX: --job-name=reclusive-dog-4149
#FLUX: -t=173400
#FLUX: --urgency=16

Number_ch=`printf %02d $SLURM_ARRAY_TASK_ID`
longshot -A -c 2 -e 2 -r Ha412HOChr$Number_ch -s ANN1372_LS_NGMLR --bam Sequel.RunS142_S2.002.ANN1372-3.ccs_NGMLR_bq_t.bam --ref Ha412HOv2.0-20181130.fasta --out Ha412HO_ANN1372-3$Number_ch.vcf
module load nixpkgs/16.09  gcc/7.3.0 bcftools/1.10.2
cat  Ha412HO_ANN1372-301.vcf \
     Ha412HO_ANN1372-302.vcf \
     Ha412HO_ANN1372-303.vcf \
     Ha412HO_ANN1372-304.vcf \
     Ha412HO_ANN1372-305.vcf \
     Ha412HO_ANN1372-306.vcf \
     Ha412HO_ANN1372-307.vcf \
     Ha412HO_ANN1372-308.vcf \
     Ha412HO_ANN1372-309.vcf \
     Ha412HO_ANN1372-310.vcf \
     Ha412HO_ANN1372-311.vcf \
     Ha412HO_ANN1372-312.vcf \
     Ha412HO_ANN1372-313.vcf \
     Ha412HO_ANN1372-314.vcf \
     Ha412HO_ANN1372-315.vcf \
     Ha412HO_ANN1372-316.vcf \
     Ha412HO_ANN1372-317.vcf | grep -v "#" | grep PASS > Ha412HO_ANN1372-all_NH_PASS.vcf
grep "#" Ha412HO_ANN1372-301.vcf > header.txt
cat header.txt Ha412HO_ANN1372-all_NH_PASS.vcf | bgzip -c > Ha412HO_ANN1372-all_PASS_WH_NGMLR.vcf.gz
rm header.txt
rm Ha412HO_ANN1372-all_NH_PASS.vcf
