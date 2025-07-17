#!/bin/bash
#FLUX: --job-name=salted-fork-6226
#FLUX: -n=2
#FLUX: --queue=long
#FLUX: --urgency=16

module load nextflow/22.04.3
Assembly_Name=$(basename "$( pwd )")
Forward="RawData/*_R1.fastq.gz"
Reverse="RawData/*_R2.fastq.gz"
CCS='RawData/*.fastq'
Busco="" #Busco will not be run
Yahs="-y" #Yahs will be run
Polish_Type="simple" #Simple Polishing
HiFi_Type="default"
Runner="slurm_usda_mem"
Threads="32"
Busco_Location="-l /project/ag100pest/software/OTB_test/busco"
Busco_DB="-p insecta_odb10"
if [[ -z "$BUSCO" ]]; then
  ./otb.sh -n ${Assembly_Name} -f "$( echo ${Forward})" -r "$(echo ${Reverse})" -in "$(echo ${CCS})" -m ${HiFi_Type} -t ${Threads} ${Yahs} ${Busco} --polish_type ${Polish_Type} --runner ${Runner} -c -s
else
  ./otb.sh -n ${Assembly_Name} -f "$( echo ${Forward})" -r "$(echo ${Reverse})" -in "$(echo ${CCS})" -m ${HiFi_Type} -t ${Threads} ${Yahs} ${Busco} ${Busco_Location} ${Busco_DB} --polish_type ${Polish_Type} --runner ${Runner} -c -s
fi
