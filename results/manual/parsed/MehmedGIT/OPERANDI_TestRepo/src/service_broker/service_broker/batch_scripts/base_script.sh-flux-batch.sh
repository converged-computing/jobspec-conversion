#!/bin/bash
#FLUX: --job-name=gloopy-train-1609
#FLUX: -c=2
#FLUX: --queue=medium
#FLUX: --priority=16

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
