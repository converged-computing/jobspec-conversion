#!/bin/bash
#FLUX: --job-name=bgen2bfile_infomaf
#FLUX: -c=20
#FLUX: --queue=compute
#FLUX: -t=86400
#FLUX: --urgency=16

CHR=${SLURM_ARRAY_TASK_ID}
/gfs/work/ceijsbouts/app/plink2 \
--bgen /gfs/archive/jostins/ukbb/v3/imputation/ukb_imp_chr${CHR}_v3.bgen \
--sample /gfs/work/ceijsbouts/ibs/sample/ukb17670_imp_chr22_v3_s487327.sample \
--maf 0.0001 \
--make-bed \
--mach-r2-filter 0.9 2.0 \
--out /gfs/archive/jostins/ukbb/v3/imputation_bfile_infomaf_filtered/ukb_imp_chr${CHR}_v3
