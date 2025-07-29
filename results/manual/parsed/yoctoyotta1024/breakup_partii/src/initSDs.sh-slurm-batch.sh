#!/bin/bash
#FLUX: --job-name=initSDs
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

module load python3/2022.01-gcc-11.2.0
source activate /work/mh1126/m300950/condaenvs/superdropsenv
wetdry=${1}
path2CLEO=${HOME}/CLEO/
path2build=/work/mh1126/m300950/droplet_breakup_partii/build/
tmp_configfile=${path2build}/tmp/buii_config.txt 
python=/work/mh1126/m300950/condaenvs/superdropsenv/bin/python
if [ "${wetdry}" != "dry" ] && [ "${wetdry}" != "wet" ];
then
  echo "please specify 'wet' or 'dry' initial superdroplets"
elif [ "${wetdry}" == "dry" ];
then
  ${python} initSDs_dry.py ${path2CLEO} ${path2build} ${tmp_configfile}
elif [ "${wetdry}" == "wet" ];
then
  ${python} initSDs_wet.py ${path2CLEO} ${path2build} ${tmp_configfile}
fi
