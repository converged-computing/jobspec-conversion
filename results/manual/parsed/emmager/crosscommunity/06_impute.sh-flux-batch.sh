#!/bin/bash
#FLUX: --job-name=impute2
#FLUX: -t=3600
#FLUX: --urgency=16

module load conda 
conda activate /Genomics/argo/users/emmarg/miniforge3/envs/impute2
snparcherdir=/Genomics/ayroleslab2/emma/snpArcher/past/results/hg38/
past_proj_dir=/Genomics/ayroleslab2/emma/pastoralist_project/
scratch_dir=/scratch/tmp/emmarg/PastGWAS/mappingqual10/
chr=7
start=$(sed -n ${SLURM_ARRAY_TASK_ID}p ~/Chr${chr}.Intervals.start.sorted.txt)
end=$(sed -n ${SLURM_ARRAY_TASK_ID}p ~/Chr${chr}.Intervals.end.sorted.txt)
gen=${scratch_dir}chr${chr}.hg19.GQ10.gen.gz
map=/Genomics/ayroleslab2/alea/ref_genomes/public_datasets/1000GP_Phase3/genetic_map_chr${chr}_combined_b37.txt
phased_haps2=${past_proj_dir}Turkana_highcov_vcfs/high_cov.SNP1.hg19_chr${chr}.phased_v2.haps
phased_leg=${past_proj_dir}Turkana_highcov_vcfs/high_cov.SNP1.hg19_chr${chr}.phased_v2.leg
impute2 \
 -m $map \
 -h $phased_haps2 \
 -l $phased_leg  \
 -g $gen \
 -int $start $end \
 -Ne 20000 \
 -o /scratch/tmp/emmarg/PastGWAS/imputed/impute1panel.${chr}.${start}.${end}.hg19_GQ10
