#!/bin/bash
#FLUX: --job-name=RunDataPreparations
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='../../singularitycache'
export NXF_HOME='../../nextflowcache'

module load java-1.8.0_40
module load singularity/3.5.3
module load squashfs/4.4
export SINGULARITY_CACHEDIR=../../singularitycache
export NXF_HOME=../../nextflowcache
nextflow_path=../../tools
genotypes_hdf5=../../3_ConvertVcf2Hdf5/output # Folder with genotype files in .hdf5 format
qc_data_folder=../../1_DataQC/output # Folder containing QCd data, inc. expression and covariates
output_path=../output
NXF_VER=21.10.6 ${nextflow_path}/nextflow run PerCohortDataPreparations.nf \
--hdf5 ${genotypes_hdf5} \
--qcdata ${qc_data_folder} \
--outdir ${output_path} \
-profile slurm,singularity \
-resume
