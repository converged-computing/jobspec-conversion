#!/bin/bash
#FLUX: --job-name=fuzzy-punk-7115
#FLUX: --urgency=16

in_vcf="/scratch/users/magu/deepmix/data/vcf/expanded_ref_panel.vcf.gz"
ml load biology; ml load bcftools; ml load htslib # bcftools, bgzip, tabix
chm=${SLURM_ARRAY_TASK_ID:=20}
vcf2="$SCRATCH/deepmix/data/vcf/panel_chr${chm}.vcf.gz"
echo $vcf2
if [ ! -f $vcf2 ]; then # in case you have to rerun
	# if you get errors, check if it's chrN or just N
	bcftools view -r "${chm}" $in_vcf | bgzip -c > $vcf2
	tabix $vcf2
fi
npz="$SCRATCH/deepmix/data/panel_chr${chm}"
echo $npz
python3 vcf_to_numpy.py $vcf2 $npz
