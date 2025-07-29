#!/bin/bash
#FLUX: --job-name=__job_name omkm run
#FLUX: --queue=__partition
#FLUX: --urgency=16

export VALET_PATH='/work/ccei_biomass/sw/valet'

vpkg_require openmkm/20191112:gcc9
cd "./omkm"
FOLDER_FILE='./folderlist.txt'
FOLDER=$(sed -n "$SLURM_ARRAY_TASK_ID p" "$FOLDER_FILE")
cd "$FOLDER"
echo Running $FOLDER
omkm reactor.yaml thermo.xml
