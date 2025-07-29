#!/bin/bash
#SBATCH --output=/home/users/mmustaf/jobs_output/job-%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --partition=medium
#SBATCH --constraint=scratch

module purge
module load singularity # loads "git" and "go" as well
module load nextflow # loads "openjdk" as well
if [ ! -d "/scratch1/users/${USER}" ]; then
  mkdir "/scratch1/users/${USER}"
fi
TEMPDIR=$(mktemp -d "/scratch1/users/${USER}/XXXXXXXX")
if [ ! -d "${TEMPDIR}" ]; then
  echo "Temp directory was not created!"
  exit 1
fi
cp -rf /home/users/mmustaf/workflow5/bin ${TEMPDIR}
cd ${TEMPDIR}/bin
nextflow run seq_ocrd_wf_single_processor.nf --tempdir ${TEMPDIR}/bin
hostname
slurm_resources
