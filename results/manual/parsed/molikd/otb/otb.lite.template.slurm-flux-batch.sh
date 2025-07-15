#!/bin/bash
#FLUX: --job-name=bloated-puppy-6810
#FLUX: --urgency=16

module load nextflow/22.04.3
module load singularityCE
Assembly_Name=$(basename "$( pwd )")
CCS='RawData/*.fastq'
Busco="--busco" #Busco will be run
Busco_Location="-l /project/ag100pest/software/OTB_test/busco"
Busco_DB="-p insecta_odb10"
HiFi_Type="default"
Runner="slurm_usda"
Threads="32"
if [[ ! -z "$BUSCO" ]]; then
  ./otb.sh --lite -n ${Assembly_Name}  -in "$(echo "${CCS}")" -m ${HiFi_Type} -t ${Threads} --runner ${Runner} -c -s
else
  ./otb.sh --lite -n ${Assembly_Name}  -in "$(echo ${CCS})" -m ${HiFi_Type} -t ${Threads} --runner ${Runner} ${Busco} ${Busco_Location} ${Busco_DB} -c -s
fi
