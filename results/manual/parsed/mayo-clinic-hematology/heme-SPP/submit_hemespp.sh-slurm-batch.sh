#!/bin/bash
#SBATCH --job-name=mcmicro_SMM_multisample
#SBATCH --output=mcmicro-%J.log
#SBATCH --mail-user=howe.michael@mayo.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --partition=cpu-short
#SBATCH --chdir=/research/labs/hematology/hemedata/m302618/projects/spatial/cdx_pipeline_mforge/MCMICRO/

export NXF_APPTAINER_CACHEDIR='/research/labs/hematology/hemedata/m302618/apptainer/containers'

module purge
module load nextflow
module load apptainer
export NXF_APPTAINER_CACHEDIR="/research/labs/hematology/hemedata/m302618/apptainer/containers"
nextflow -C mforge_settings.config run labsyspharm/mcmicro --in 20240112_BR062124_Gonsalves_CD45 -with-report
