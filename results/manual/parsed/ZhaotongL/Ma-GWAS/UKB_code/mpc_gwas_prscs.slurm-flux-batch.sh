#!/bin/bash
#FLUX: --job-name=boopy-chip-1858
#FLUX: -t=86400
#FLUX: --priority=16

module load plink/2.00-alpha-091019
plink2 --bfile ../110K_QCed --pheno ../MET_20PC.txt --pheno-name PC${SLURM_ARRAY_TASK_ID} --variance-standardize --covar ../noMET_20PC.txt  --glm hide-covar --out mPC${SLURM_ARRAY_TASK_ID}
module load python
awk '{print $3,$6,$4,$9,$12}' mPC${SLURM_ARRAY_TASK_ID}.PC${SLURM_ARRAY_TASK_ID}.glm.linear  > mPC${SLURM_ARRAY_TASK_ID}.cs.sumstat
sed -i 's/REF/A2/'  mPC${SLURM_ARRAY_TASK_ID}.cs.sumstat
sed -i 's/ID/SNP/'  mPC${SLURM_ARRAY_TASK_ID}.cs.sumstat
python /home/panwei/lin00374/metabolites/PRScs/PRScs.py \
    --ref_dir=/home/panwei/lin00374/ldblk_ukbb_eur \
    --bim_prefix=../110K_QCed \
    --sst_file=./mPC${SLURM_ARRAY_TASK_ID}.cs.sumstat \
    --n_gwas=91469 \
    --out_dir=./PRScs_Res/prs_PC${SLURM_ARRAY_TASK_ID}
