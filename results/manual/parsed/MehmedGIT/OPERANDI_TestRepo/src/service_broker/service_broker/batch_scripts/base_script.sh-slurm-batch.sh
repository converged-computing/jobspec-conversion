#!/bin/bash
#SBATCH --output=/home/users/mmustaf/jobs_output/job-%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=32G
#SBATCH --partition=medium
#SBATCH --constraint=scratch

hostname
slurm_resources
module purge
module load singularity # loads "git" and "go" as well
module load nextflow # loads "openjdk" as well
if [ ! -d "/scratch1/users/${USER}" ]; then
  mkdir "/scratch1/users/${USER}"
fi
mkdir "/scratch1/users/${USER}/$1"
if [ ! -d "/scratch1/users/${USER}/$1" ]; then
  echo "Workspace directory was not created!"
  exit 1
fi
cp -rf "/home/users/${USER}/$1/bin" "/scratch1/users/${USER}/$1"
rm -rf "/home/users/${USER}/$1"
cd "/scratch1/users/${USER}/$1/bin" || exit
echo "DOWNLOADING THE IMAGES FROM METS FILE ... DUMMY"
nextflow run seq_ocrd_wf_single_processor.nf --volumedir "/scratch1/users/${USER}/$1/bin"
