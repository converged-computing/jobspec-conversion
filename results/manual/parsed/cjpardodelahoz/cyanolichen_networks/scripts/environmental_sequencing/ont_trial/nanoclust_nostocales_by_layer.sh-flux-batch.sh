#!/bin/bash
#FLUX: --job-name=stanky-pastry-6477
#FLUX: --queue=common
#FLUX: --priority=16

source $(conda info --base)/etc/profile.d/conda.sh
conda activate nanoclust
module load Java/11.0.8 # Requires Java >8
module load NCBI-BLAST/2.12.0-rhel8
nextflow_path="/hpc/group/bio1/carlos/apps/nextflow_22.10.6"
nanoclust_path="/hpc/group/bio1/carlos/apps/NanoCLUST"
base_dir="/hpc/group/bio1/carlos/nostoc_communities"
sample=$(cat misc_files/environmental_sequencing/ont_trial/site_layer_list.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
nanoclust_out="analyses/environmental_sequencing/ont_trial/nanoclust/nostocales/layer_pools"
reads_path="analyses/environmental_sequencing/ont_trial/nanoclust/nostocales/reads"
mkdir -p ${nanoclust_out}/${sample}
mkdir -p ${nanoclust_out}/${sample}/work
${nextflow_path}/nextflow run -work-dir ${base_dir}/${nanoclust_out}/${sample}/work \
 ${nanoclust_path}/main.nf \
 --reads "${base_dir}/${reads_path}/${sample}_nostocales.fastq" \
 --db "${nanoclust_path}/db/16S_ribosomal_RNA" \
 --tax "${nanoclust_path}/db/taxdb" \
 --min_read_length 1200 \
 --max_read_length 1600 \
 --outdir "${base_dir}/${nanoclust_out}/${sample}"
