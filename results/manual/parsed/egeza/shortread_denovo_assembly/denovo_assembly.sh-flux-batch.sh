#!/bin/bash
#FLUX: --job-name=shortreaddenovo_assembly
#FLUX: -n=15
#FLUX: --queue=Main
#FLUX: -t=1209600
#FLUX: --urgency=16

echo "Assmbly Started"
proj="/cbio/projects/026/"
module load  nextflow/23.04.4 
module load openmpi/4.1.5
cd /cbio/projects/026/shortread_denovo_assembly_pipeline/
nextflow run main.nf --datadir "/cbio/projects/026/data_1"  \
	--outdir "/cbio/projects/026/results/run1" \
	-config "/cbio/projects/026/shortread_denovo_assembly_pipeline/nextflow.config" \
	-profile singularity,ilifu -resume
