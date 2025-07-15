#!/bin/bash
#FLUX: --job-name=moolicious-lentil-3096
#FLUX: --queue=cpu-short
#FLUX: -t=7200
#FLUX: --urgency=16

export NXF_APPTAINER_CACHEDIR='/research/labs/hematology/hemedata/m302618/apptainer/containers'

module purge
module load nextflow
module load apptainer
export NXF_APPTAINER_CACHEDIR="/research/labs/hematology/hemedata/m302618/apptainer/containers"
nextflow -C mforge_settings.config run labsyspharm/mcmicro --in 20240112_BR062124_Gonsalves_CD45 -with-report
