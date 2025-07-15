#!/bin/bash
#FLUX: --job-name=plsareal
#FLUX: -c=20
#FLUX: --queue=shared
#FLUX: -t=7200
#FLUX: --priority=16

export MODULEPATH='$MODULEPATH:/share/apps/compute/modulefiles && module purge && module load gnu/7.2.0 cmake/3.12.1 && /home/oleksanf/miniconda3/bin/python3 /oasis/projects/nsf/csd635/oleksanf/github/mixer_private/precimed/mixer.py snps \'

source /cluster/bin/jobsetup
module purge   # clear any inherited modules
module load plink
set -o errexit # exit on errors
export MODULEPATH=$MODULEPATH:/share/apps/compute/modulefiles && module purge && module load gnu/7.2.0 cmake/3.12.1 && /home/oleksanf/miniconda3/bin/python3 /oasis/projects/nsf/csd635/oleksanf/github/mixer_private/precimed/mixer.py snps \
	--bim-file /oasis/projects/nsf/csd635/oleksanf/UKBDATA/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc.bim \
	--ld-file /oasis/projects/nsf/csd635/oleksanf/UKBDATA/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc.run1.ld \
	--lib /oasis/projects/nsf/csd635/oleksanf/github/mixer_private/src/build/lib/libbgmg.so \
	--out /oasis/projects/nsf/csd635/oleksanf/UKBDATA/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_qc.prune_maf0p05_rand3M_r2p8_rep${SLURM_ARRAY_TASK_ID}.snps \
	--chr2use 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 \
	--seed ${SLURM_ARRAY_TASK_ID} --r2 0.8 --maf 0.05 --subset 3000000 \
