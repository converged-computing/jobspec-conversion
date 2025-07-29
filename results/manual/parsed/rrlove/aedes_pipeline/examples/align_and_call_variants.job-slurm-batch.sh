#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --array=1-12%4

source activate varaedes
cd ${aedes_path}data/output/
mapfile -t sample_list <${aedes_path}data/Colombia_batch_2.090621.txt
sample=${sample_list[${SLURM_ARRAY_TASK_ID}-1]}
if [ ! -d ${sample}_dir ]; then
  mkdir ${sample}_dir
fi
cd ${sample}_dir/
nextflow ${aedes_path}pipeline/main.nf \
--ref "${aedes_path}refs/aegy/VectorBase-50_AaegyptiLVP_AGWG_Genome.fasta" \
--reads "${data_path}${sample}*" \
--sample "${sample}" \
--intervals "${aedes_path}refs/aegy/intervals/*.list" \
--basedir "${aedes_path}data/output/${sample}_dir/" \
--sequenced \
--confident_ref
