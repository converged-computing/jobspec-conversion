#!/bin/bash
#FLUX: --job-name=LDclump_meta
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --priority=16

CHR=${SLURM_ARRAY_TASK_ID}
METAS=(metal_ICD_diag metal_ROME_Q metal_Qonly_Qnon_any metal_MAURO metal_ICD_ROME_EURUSA_Qonly_Qnon metal_ICD_ROME_EURUSA_any metal_ICD_diag)
module load bio/plink/1.90b6.7
for m in {1..7}
do
META=${METAS[${m}-1]}
echo $META
echo $CHR
mkdir /gfs/work/ceijsbouts/ibs/clump/clumped/${META}
plink \
--bfile /gfs/archive/jostins/ukbb/v3/imputation_bfile_infomaf_filtered/ukb_imp_chr${CHR}_v3 \
--keep /gfs/work/ceijsbouts/ibs/clump/keep_unrelated/10k_passing_sqc.txt \
--clump /gfs/work/ceijsbouts/ibs/clump/sumstats_meta/${META}/chr${CHR}.sumstats \
--clump-field P-value \
--clump-snp-field MarkerName \
--clump-p1 5e-8 \
--clump-p2 0.05 \
--clump-r2 0.05 \
--clump-kb 5000 \
--clump-verbose \
--clump-allow-overlap \
--out /gfs/work/ceijsbouts/ibs/clump/clumped/${META}/chr${CHR}
done
