#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -t=43200
#FLUX: --urgency=16

module load singularity
BIDS_dir=/blue/stevenweisberg/stevenweisberg/MVPA_ARROWS/
MRIQC_output_dir=/blue/stevenweisberg/stevenweisberg/MVPA_ARROWS/derivatives/mriqc
code_dir=/blue/stevenweisberg/stevenweisberg/MVPA_ARROWS/code/hipergator
MRIQC_singularity=/blue/stevenweisberg/stevenweisberg/hipergator_neuro/mriqc/mriqc_latest.sif
for SUB in {107..128}
do
  # Skip 111 and 119
  [ "$SUB" -eq 111 ] && continue
  [ "$SUB" -eq 119 ] && continue
  # loops through sessions. Get rid of this loop entirely if there is only one session. Also get rid of '-s 0${ses}' in step 2
  for ses in 1
  do
  singularity run --cleanenv $MRIQC_singularity $BIDS_dir $MRIQC_output_dir participant --participant-label $SUB --hmc-fsl --fd_thres 2 --work-dir $MRIQC_output_dir --float32 group
  done
done
