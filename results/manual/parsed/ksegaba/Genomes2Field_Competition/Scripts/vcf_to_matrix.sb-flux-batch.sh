#!/bin/bash
#FLUX: --job-name=fastphase2csv
#FLUX: -t=14400
#FLUX: --urgency=16

cd /mnt/home/seguraab/Shiu_Lab/Collabs/Maize_GxE_Competition_Data/Training_Data
tassel=/mnt/home/seguraab/Shiu_Lab/Project/External_software/tasseladmin-tassel-5-standalone-8b0f83692ccb
plinkk=/mnt/home/seguraab/Shiu_Lab/Project/External_software
${tassel}/run_pipeline.pl -fork1 \
    -vcf 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed.vcf \
    -export 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed.hmp.txt \
    -exportType Hapmap -Xmx30g -Xms30g
${tassel}/run_pipeline.pl -fork1 \
    -vcf 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed.vcf \
    -export 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed.hmp.txt \
    -exportType Hapmap -Xmx40g -Xms10g
${tassel}/run_pipeline.pl \
    -importGuess 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed.hmp.txt \
    -KinshipPlugin -method Centered_IBS -endPlugin \
    -export 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed_kinship.txt \
    -exportType SqrMatrix -Xmx30g -Xms10g
${tassel}/run_pipeline.pl \
    -importGuess 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed.hmp.txt \
    -KinshipPlugin -method Centered_IBS -endPlugin \
    -export 5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed_kinship.txt \
    -exportType SqrMatrix -Xmx40g -Xms10g
vcf=5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed.vcf
plnk=5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_BEAGLE_imputed.plink
${plinkk}/plink2 --vcf ${vcf} --make-bed --out ${plnk} # convert to PLINK format
${plinkk}/plink --bfile ${plnk} --recode --out ${plnk} # generate ped + map files
${plinkk}/plink --file ${plnk} --recodeA --out ${plnk} # recode genotypes
vcf=5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed.vcf
plnk=5_Genotype_Data_All_Years_maf005_maxmiss090_cleaned_LinkImpute_imputed.plink
${plinkk}/plink2 --vcf ${vcf} --make-bed --out ${plnk}
${plinkk}/plink --bfile ${plnk} --recode --out ${plnk}
${plinkk}/plink --file ${plnk} --recodeA --out ${plnk}
scontrol show job $SLURM_JOB_ID
