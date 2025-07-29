#!/bin/bash
#SBATCH --job-name=20221215-cgig-nextflow-epdiverse-snp-haws-hawaii-base_config
#SBATCH --account=srlab
#SBATCH --mail-user=samwhite@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --time=12-00:00:00
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20221215-cgig-nextflow-epdiverse-snp-haws-hawaii-base_config

bams_dir="/gscratch/scrubbed/samwhite/data/C_gigas/BSseq"
epi_snp="/gscratch/srlab/programs/epidiverse-pipelines/snp"
genome_fasta="/gscratch/srlab/sam/data/C_gigas/genomes/cgigas_uk_roslin_v1_genomic-mito.fa"
nextflow="/gscratch/srlab/programs/nextflow-21.10.6-all"
nextflow_version="20.07.1"
set -e
. "/gscratch/srlab/programs/anaconda3/etc/profile.d/conda.sh"
conda activate epidiverse-snp_env
NXF_VER=${nextflow_version} \
${nextflow} run \
${epi_snp} \
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
