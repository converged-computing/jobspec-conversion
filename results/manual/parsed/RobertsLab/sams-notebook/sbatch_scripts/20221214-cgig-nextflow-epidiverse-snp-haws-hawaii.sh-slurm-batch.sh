#!/bin/bash
#FLUX: --job-name=20221214-cgig-nextflow-epidiverse-snp-haws-hawaii
#FLUX: --queue=srlab
#FLUX: -t=1036800
#FLUX: --urgency=16

bams_dir="/gscratch/scrubbed/samwhite/data/C_gigas/BSseq"
epi_snp="/gscratch/srlab/programs/epidiverse-pipelines/snp"
genome_fasta="/gscratch/srlab/sam/data/C_gigas/genomes/cgigas_uk_roslin_v1_genomic-mito.fa"
nextflow="/gscratch/srlab/programs/nextflow-21.10.6-all"
nextflow_version="20.07.1"
set -e
. "/gscratch/srlab/programs/anaconda3/etc/profile.d/conda.sh"
conda activate epidiverse-snp_env
cp "${epi_snp}"/config/base-srlab_500GB_node.config .
NXF_VER=${nextflow_version} \
${nextflow} run \
${epi_snp} \
-config ./base-srlab_500GB_node.config \
--input ${bams_dir} \
--reference ${genome_fasta} \
--variants \
--clusters
if [[ "${#programs_array[@]}" -gt 0 ]]; then
  echo "Logging program options..."
  for program in "${!programs_array[@]}"
  do
    {
    echo "Program options for ${program}: "
    echo ""
    # Handle samtools help menus
    if [[ "${program}" == "samtools_index" ]] \
    || [[ "${program}" == "samtools_sort" ]] \
    || [[ "${program}" == "samtools_view" ]]
    then
      ${programs_array[$program]}
    # Handle DIAMOND BLAST menu
    elif [[ "${program}" == "diamond" ]]; then
      ${programs_array[$program]} help
    # Handle NCBI BLASTx menu
    elif [[ "${program}" == "blastx" ]]; then
      ${programs_array[$program]} -help
    fi
    ${programs_array[$program]} -h
    echo ""
    echo ""
    echo "----------------------------------------------"
    echo ""
    echo ""
  } &>> program_options.log || true
    # If MultiQC is in programs_array, copy the config file to this directory.
    if [[ "${program}" == "multiqc" ]]; then
      cp --preserve ~/.multiqc_config.yaml multiqc_config.yaml
    fi
  done
  echo "Finished logging programs options."
  echo ""
fi
echo "Logging system \$PATH..."
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log
echo "Finished logging system $PATH."
