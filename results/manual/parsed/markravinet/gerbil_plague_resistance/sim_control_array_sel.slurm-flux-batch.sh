#!/bin/bash
#FLUX: --job-name=array_slim
#FLUX: -t=7200
#FLUX: --priority=16

module purge
module load BCFtools/1.9-intel-2018b VCFtools/0.1.16-intel-2018b-Perl-5.28.0
echo "Run number ${SLURM_ARRAY_TASK_ID}"
slim gerbil_sims_exp_sel_v2.slim > test_sel_${SLURM_ARRAY_TASK_ID}.out
tail -n+18 test_sel_${SLURM_ARRAY_TASK_ID}.out | bgzip -c > test_sel_${SLURM_ARRAY_TASK_ID}.vcf.gz
vcftools --gzvcf test_sel_${SLURM_ARRAY_TASK_ID}.vcf.gz --weir-fst-pop pop1 --weir-fst-pop pop2 --out test_sel_${SLURM_ARRAY_TASK_ID}
vcftools --gzvcf test_sel_${SLURM_ARRAY_TASK_ID}.vcf.gz --weir-fst-pop pop1 --weir-fst-pop pop2 \
--fst-window-size 5000 --fst-window-step 5000 --out test_sel_${SLURM_ARRAY_TASK_ID}
