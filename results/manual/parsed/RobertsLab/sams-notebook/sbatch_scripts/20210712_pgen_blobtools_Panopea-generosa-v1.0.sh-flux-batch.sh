#!/bin/bash
#FLUX: --job-name=20210712_pgen_blobtools_Panopea-generosa-v1.0
#FLUX: --queue=coenv
#FLUX: -t=864000
#FLUX: --priority=16

module load blobtoolkit-v2.6.1.module
wd=$(pwd)
echo "Working directory is ${wd}."
echo ""
base_dir=${wd}/blobtoolkit
evalue="1.0e-10"
ncbi_tax_id=1049056
species="Panopea generosa"
root=1
threads=40
assembly_name=Panopea_generosa_v1
orig_fasta=/gscratch/srlab/sam/data/P_generosa/genomes/Panopea-generosa-v1.0.fa
fastq_checksums=fastq_checksums.md5
trimmed_reads_dir=/gscratch/scrubbed/samwhite/outputs/20210401_pgen_fastp_10x-genomics
genome_fasta=${wd}/Panopea_generosa_v1.fasta.gz
blobtools2=/gscratch/srlab/programs/blobtoolkit-v2.6.1/blobtools2
btk_pipeline=/gscratch/srlab/programs/blobtoolkit-v2.6.1/pipeline
conda_dir=/gscratch/srlab/programs/anaconda3/envs/btk_env
busco_dbs=/gscratch/srlab/sam/data/databases/BUSCO
btk_ncbi_tax_dir=/gscratch/srlab/blastdbs/20210401_ncbi_taxonomy
ncbi_db=/gscratch/srlab/blastdbs/20210401_ncbi_nt
ncbi_db_name="nt"
uniprot_db=/gscratch/srlab/blastdbs/20210401_uniprot_btk
uniprot_db_name=reference_proteomes
declare -A programs_array
programs_array=()
set -e
. "/gscratch/srlab/programs/anaconda3/etc/profile.d/conda.sh"
if [ ! -f "${genome_fasta}" ]; then
  gzip -c ${orig_fasta} > "${genome_fasta}"
fi
if [ ! -f "${genome_fasta}" ]; then
  md5sum "${genome_fasta}" > genome_fasta.md5
fi
if [ ! -f "reads_1.fastq.gz" ]; then
  for fastq in "${trimmed_reads_dir}"/*R1*.fq.gz
  do
    echo ""
    echo "Generating checksum for ${fastq}"
    md5sum "${fastq}" >> ${fastq_checksums}
    echo "Checksum generated for ${fastq}."
    echo ""
    echo "Concatenating ${fastq} to reads_1.fastq.gz"
    cat "${fastq}" >> reads_1.fastq.gz
    echo "Finished concatenating ${fastq} to reads_1.fastq.gz"
  done
fi
if [ ! -f "reads_2.fastq.gz" ]; then
  for fastq in "${trimmed_reads_dir}"/*R2*.fq.gz
  do
    echo ""
    echo "Generating checksum for ${fastq}"
    md5sum "${fastq}" >> ${fastq_checksums}
    echo "Checksum generated for ${fastq}."
    echo ""
    echo "Concatenating ${fastq} to reads_2.fastq.gz"
    cat "${fastq}" >> reads_2.fastq.gz
    echo "Finished concatenating ${fastq} to reads_2.fastq.gz"
  done
fi
scaffold_count=$(grep -c ">" "${genome_fasta}")
genome_nucleotides_count=$(grep -v ">" "${genome_fasta}" | wc | awk '{print $3-$1}')
if [ -f "config.yaml" ]; then
  rm "config.yaml"
fi
{
  printf "%s\n" "assembly:"
  printf "%2s%s\n" "" "accession: draft" "" "file: ${genome_fasta}" "" "level: scaffold" "" "scaffold-count: ${scaffold_count}" "" "span: ${genome_nucleotides_count}"
  printf "%2s%s\n" "" "prefix: ${assembly_name}"
  printf "%s\n" "busco:"
  printf "%2s%s\n" "" "download_dir: ${busco_dbs}"
  printf "%2s%s\n" "" "lineages:"
  printf "%4s%s\n" "" "- arthropoda_odb10" "" "- eukaryota_odb10" "" "- metazoa_odb10" "" "- bacteria_odb10" "" "- archaea_odb10"
  printf "%2s%s\n" "" "basal_lineages:"
  printf "%4s%s\n" "" "- archaea_odb10" "" "- bacteria_odb10" "" "- eukaryota_odb10"
  printf "%s\n" "reads:"
  printf "%2s%s\n" "" "paired:"
  printf "%4s%s\n" "" "- prefix: reads"
  printf "%6s%s\n" "" "platform: ILLUMINA" "" "file: ${wd}/reads_1.fastq.gz;${wd}/reads_2.fastq.gz"
  printf "%s\n" "settings:"
  printf "%2s%s\n" "" "taxdump: ${btk_ncbi_tax_dir}"
  printf "%2s%s\n" "" "blast_chunk: 100000"
  printf "%2s%s\n" "" "blast_max_chunks: 10"
  printf "%2s%s\n" "" "blast_overlap: 0"
  printf "%2s%s\n" "" "blast_min_length: 1000"
  printf "%s\n" "similarity:"
  printf "%2s%s\n" "" "defaults:"
  printf "%4s%s\n" "" "evalue: ${evalue}" "" "max_target_seqs: 10" "" "import_evalue: 1.0e-25" "" "taxrule: buscogenes"
  printf "%2s%s\n" "" "diamond_blastx:"
  printf "%4s%s\n" "" "name: ${uniprot_db_name}" "" "path: ${uniprot_db}"
  printf "%2s%s\n" "" "diamond_blastp:"
  printf "%4s%s\n" "" "name: ${uniprot_db_name}" "" "path: ${uniprot_db}" "" "import_max_target_seqs: 100000"
  printf "%2s%s\n" "" "blastn:"
  printf "%4s%s\n" "" "name: ${ncbi_db_name}" "" "path: ${ncbi_db}"
  printf "%s\n" "taxon:"
  printf "%2s%s\n" "" "name: ${species}" "" "taxid: '${ncbi_tax_id}'"
} >> config.yaml
conda activate btk_env
snakemake -p \
--use-conda \
--conda-prefix ${conda_dir} \
--directory "${base_dir}" \
--configfile "${wd}"/config.yaml \
--stats ${assembly_name}.blobtoolkit.stats \
-j ${threads} \
--rerun-incomplete \
-s ${btk_pipeline}/blobtoolkit.smk \
--resources btk=1
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
fi
{
  date
  echo ""
  echo "System PATH for $SLURM_JOB_ID"
  echo ""
  printf "%0.s-" {1..10}
  echo "${PATH}" | tr : \\n
} >> system_path.log
echo "Finished logging system PATH"
