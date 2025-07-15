#!/bin/bash
#FLUX: --job-name=pusheena-lemur-0258
#FLUX: --queue=scavenger
#FLUX: --urgency=16

source $(conda info --base)/etc/profile.d/conda.sh
conda activate nanoclust
module load Java/11.0.8 # Requires Java >8
module load NCBI-BLAST/2.12.0-rhel8
nextflow_path="/hpc/group/bio1/carlos/apps/nextflow_22.10.6"
nanoclust_path="/hpc/group/bio1/carlos/apps/NanoCLUST"
base_dir="/hpc/group/bio1/carlos/nostoc_communities"
${nextflow_path}/nextflow run ${nanoclust_path}/main.nf \
 --reads "${base_dir}/data/reads/8729_Delivery/fastq_pass/FAW42562_pass_barcode01_ec33fcdb_7019a9e0_0.fastq" \
 --db "${nanoclust_path}/db/16S_ribosomal_RNA" \
 --tax "${nanoclust_path}/db/taxdb" \
 --min_read_length 1200 \
 --max_read_length 1600 \
 --outdir "${base_dir}/analyses/environmental_sequencing/ont_trial/nanoclust/a"
