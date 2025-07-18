#!/bin/bash
#FLUX: --job-name=launch_bulkRNAseq_mutation_calling
#FLUX: --queue=long
#FLUX: -t=864000
#FLUX: --urgency=16

module load java/18
base_dir="/cluster/projects/gaitigroup/Users/Joan/"
nf_exec="/cluster/home/t119972uhn/nextflow-23.04.3-all"
work_dir="${base_dir}/nf_work_bulk_rnasq_mutation_calling"
nf_profile="slurm"
echo "$(date)   Create work directory for nextflow if not existing..."
mkdir -p "${work_dir}"
echo "$(date)   Setup paths..."
project_dir="${base_dir}/mutation-calling"
outdir="${project_dir}/nf-logs"
run_name="test_set_rerun"
data_dir="${project_dir}/001_data/"
sample_sheet="${project_dir}/000_misc/test_set.csv"
ref_genome="${data_dir}/reference_genome/Homo_sapiens_assembly19.fasta"
gtf_path="${data_dir}/References/Homo_sapiens_assembly19.gtf"
dbcosmic="${data_dir}/References/b37_cosmic_v54_120711.vcf"
dbSNP="${data_dir}/References_v2/Homo_sapiens_assembly19.dbsnp138.vcf"
indel_db1="${data_dir}/References_v2/1000G_omni2.5.b37.vcf.gz"
indel_db2="${data_dir}/References_v2/1000G_phase1.snps.high_confidence.b37.vcf.gz"
human_db="${data_dir}/humandb/"
exac_bed="${data_dir}/sites_to_remove_dbs/exac_mat.bed"
darned_bed="${data_dir}/sites_to_remove_dbs/Darned_mat.bed"
radar_bed="${data_dir}/sites_to_remove_dbs/Radar_mat.bed"
pseudo_genes_bed="${data_dir}/sites_to_remove_dbs/pseudo_genes.bed"
pseudo_genes_bed2="${data_dir}/sites_to_remove_dbs/pseudo_genes_2.bed"
jar_files="${data_dir}/jar_files"
star_index_dir="${data_dir}/indices/STAR_Homo_sapiens_assembly19"
hisat_index_dir="${data_dir}/indices/HISAT_Homo_sapiens_assembly19"
bwa_index_dir="${data_dir}/indices/BWA_Homo_sapiens_assembly19"
echo "$(date)   Create output directories..."
mkdir -p "${data_dir}/indices"
mkdir -p "${project_dir}/logs"
mkdir -p "${project_dir}/output/${run_name}/normal"
mkdir -p "${project_dir}/output/${run_name}/tumor"
mkdir -p "${project_dir}/output/${run_name}/mutations_prefiltered"
echo "$(date)   Start the pipeline..."
${nf_exec} run ${project_dir} -with-report -with-trace \
    -profile ${nf_profile} \
    -w $work_dir \
    --sample_sheet ${sample_sheet} \
    --ref_genome ${ref_genome} \
    --gtf_path ${gtf_path} \
    --dbSNP ${dbSNP} \
    --dbcosmic ${dbcosmic} \
    --indel_db1 ${indel_db1} \
    --indel_db2 ${indel_db2} \
    --jar_files ${jar_files} \
    --star_index_dir ${star_index_dir} \
    --hisat_index_dir ${hisat_index_dir} \
    --bwa_index_dir ${bwa_index_dir} \
    --human_db ${human_db} \
    --exac_bed ${exac_bed} \
    --darned_bed ${darned_bed} \
    --radar_bed ${radar_bed} \
    --pseudo_genes_bed ${pseudo_genes_bed} \
    --pseudo_genes_bed2 ${pseudo_genes_bed2} \
    --min_alt_counts ${min_alt_counts} \
    --outdir ${outdir} \
    --run_name ${run_name}
echo "$(date)   COMPLETED!"
