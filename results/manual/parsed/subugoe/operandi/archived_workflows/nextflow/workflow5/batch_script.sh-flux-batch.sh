#!/bin/bash
#FLUX: --job-name=rainbow-punk-0497
#FLUX: -c=4
#FLUX: --queue=medium
#FLUX: --urgency=16

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
