#!/bin/bash
#FLUX: --job-name=evasive-hope-8023
#FLUX: -c=10
#FLUX: --urgency=16

source activate varaedes
ref=${aedes_in_path}refs/aegy/VectorBase-50_AaegyptiLVP_AGWG_Genome.fasta
intervals_dir=${aedes_in_path}refs/aegy/intervals/chunks/
chromlist=("AaegL5_1" "AaegL5_2" "AaegL5_3" "others")
ntaskslist=(16 24 21 1)
chrom=${chromlist[${SLURM_ARRAY_TASK_ID}-1]}
ntasks=${ntaskslist[${SLURM_ARRAY_TASK_ID}-1]}
mapfile=${aedes_in_path}data/output/all_confident_sites_${chrom}.021722.map
workspace_path=db_all_confident_sites_${chrom}_021722
out_prefix=whole_sample_all_confident_${chrom}_021722
cd ${aedes_out_path}vcf/all_samples_021722/
mkdir -p whole_sample_${chrom}_021722 && cd whole_sample_${chrom}_021722
parallel --max-procs=${SLURM_CPUS_PER_TASK} \
nextflow ${aedes_in_path}pipeline/genotype_gvcfs/main.nf \
--ref ${ref} \
--basedir ${aedes_out_path} \
--intervals ${intervals_dir}${chrom}_{1}.list \
--mapfile ${mapfile} \
--workspace_path ${workspace_path}_{1} \
--outprefix ${out_prefix}_{1} \
--memfactor 2 \
--confident_ref ::: $(seq 1 ${ntasks})
