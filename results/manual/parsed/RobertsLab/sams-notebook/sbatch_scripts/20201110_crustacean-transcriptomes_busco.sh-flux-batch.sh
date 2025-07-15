#!/bin/bash
#FLUX: --job-name=20201110_crustacean-transcriptomes_busco
#FLUX: --queue=coenv
#FLUX: -t=259200
#FLUX: --priority=16

export PATH='${augustus_scripts}:$PATH'
export BUSCO_CONFIG_FILE='${busco_config_ini}'
export THREADS_DAEMON_MODEL='1'

wd=$(pwd)
transcriptomes_array=(
/gscratch/srlab/sam/data/C_maenas/transcriptomes/GBXE01.1.fsa_nt \
/gscratch/srlab/sam/data/L_vannamei/transcriptomes/Trinity_Trimmed_Whiteleg_Shrimp_Transcrimptome_Assmbled_Supplemental_Data_1.fasta
)
busco_db=/gscratch/srlab/sam/data/databases/BUSCO/metazoa_odb9
augustus_species=fly
threads=28
declare -A programs_array
programs_array=(
[busco]="/gscratch/srlab/programs/busco-v3/scripts/run_BUSCO.py"
)
augustus_bin=/gscratch/srlab/programs/Augustus-3.3.2/bin
augustus_orig_config_dir=/gscratch/srlab/programs/Augustus-3.3.2/config
augustus_scripts=/gscratch/srlab/programs/Augustus-3.3.2/scripts
blast_dir=/gscratch/srlab/programs/ncbi-blast-2.8.1+/bin/
hmm_dir=/gscratch/srlab/programs/hmmer-3.2.1/src/
export PATH="${augustus_bin}:$PATH"
export PATH="${augustus_scripts}:$PATH"
busco_config_default=/gscratch/srlab/programs/busco-v3/config/config.ini.default
busco_config_ini=${wd}/config.ini
export BUSCO_CONFIG_FILE="${busco_config_ini}"
cp ${busco_config_default} "${busco_config_ini}"
sed -i "/^;cpu/ s/1/${threads}/" "${busco_config_ini}"
sed -i "/^tblastn_path/ s%tblastn_path = /usr/bin/%path = ${blast_dir}%" "${busco_config_ini}"
sed -i "/^makeblastdb_path/ s%makeblastdb_path = /usr/bin/%path = ${blast_dir}%" "${busco_config_ini}"
sed -i "/^augustus_path/ s%augustus_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/bin/%path = ${augustus_bin}%" "${busco_config_ini}"
sed -i "/^etraining_path/ s%etraining_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/bin/%path = ${augustus_bin}%" "${busco_config_ini}"
sed -i "/^gff2gbSmallDNA_path/ s%gff2gbSmallDNA_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^new_species_path/ s%new_species_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^optimize_augustus_path/ s%optimize_augustus_path = /home/osboxes/BUSCOVM/augustus/augustus-3.2.2/scripts/%path = ${augustus_scripts}%" "${busco_config_ini}"
sed -i "/^hmmsearch_path/ s%hmmsearch_path = /home/osboxes/BUSCOVM/hmmer/hmmer-3.1b2-linux-intel-ia32/binaries/%path = ${hmm_dir}%" "${busco_config_ini}"
module load intel-python3_2017
module load icc_19-ompi_3.1.2
export THREADS_DAEMON_MODEL=1
for transcriptome in "${!transcriptomes_array[@]}"
do
  # Remove path from transcriptome using parameter substitution
  transcriptome_name="${transcriptomes_array[$transcriptome]##*/}"
  ## Augustus config directories
  augustus_dir=${wd}/${transcriptome_name}_augustus
  augustus_config_dir=${augustus_dir}/config
  export AUGUSTUS_CONFIG_PATH="${augustus_config_dir}"
  # Make Augustus directory if it doesn't exist
  if [ ! -d "${augustus_dir}" ]; then
    mkdir --parents "${augustus_dir}"
  fi
  # Copy Augustus config directory
  cp --preserve -r ${augustus_orig_config_dir} "${augustus_dir}"
  # Run BUSCO/Augustus training
  ${programs_array[busco]} \
  --in ${transcriptomes_array[$transcriptome]} \
  --out ${transcriptome_name} \
  --lineage_path ${busco_db} \
  --mode transcriptome \
  --cpu ${threads} \
  --long \
  --species ${augustus_species} \
  --tarzip \
  --augustus_parameters='--progress=true'
  # Capture FastA checksums for verification
  echo ""
  echo "Generating checksum for ${transcriptome_name}"
  md5sum "${transcriptomes_array[$transcriptome]}" > "${transcriptome_name}".checksum.md5
  echo "Finished generating checksum for ${transcriptome_name}"
  echo ""
done
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : \\n
} >> system_path.log
for program in "${!programs_array[@]}"
do
	{
  echo "Program options for ${program}: "
	echo ""
	${programs_array[$program]} --help
	echo ""
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo ""
} &>> program_options.log || true
done
