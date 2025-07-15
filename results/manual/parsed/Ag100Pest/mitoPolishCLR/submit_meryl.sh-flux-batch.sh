#!/bin/bash
#FLUX: --job-name=meryldb_mito
#FLUX: --urgency=16

module load merqury/1.1
module load meryl/1.0
MERQ=/project/ag100pest/software/merqury
if [ -z $1 ]; then
        printf "Usage: '$0 <SPECIES_ID> '
        Submits a list of illumina files to create a meryl db.
        Expects file I_list.txt to be in working SLURM_SUBMIT_DIR \n"
        exit 1
fi
if [[ ! -f I_list.txt ]]; then
	printf "Expects file I_list.txt in working dir or SLURM_SUBMIT_DIR. Missing this file. Try again."
else
	printf "Illimuna reads in $(cat I_list.txt) \n"
fi
mkdir -p qv
cd qv
pwd
printf "Species is $1 \n"
printf "out meryl db in ${PWD}/${1}.k31.meryl \n"
sbatch $MERQ/_submit_build.sh 31 I_list.txt $1
wait_file() {
  local file="$1"; shift
  until [ -f $file ] ; do sleep 300; done
}
wait_file ${1}.k31.hist
meryl greater-than 100 ${1}.k31.meryl output ${1}.k31.gt100.meryl
