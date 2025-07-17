#!/bin/bash
#FLUX: --job-name=EAGER
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: --urgency=16

SAMPLES=( $(find /projects1/microbiome_calculus/pacific_calculus/03-Preprocessing/eager_HG19/*/ -name '2020-05-23-14-13-EAGER.xml' -type f) ) # The outermost set of brackets defines this as a bash "list". This steps finds all the xml files in /PATH/TO/EAGER_RESULTS/ and save them as a bash "list"
SAMPLENAME=${SAMPLES[$SLURM_ARRAY_TASK_ID]} #The variable is being set every time that the SLURM_ARRAY_TASK_ID changes, so it is going through the list
unset DISPLAY # This will empty the DISPLAY variable, which can make DnaDamage throw an error and stop execution.
eagercli "${SAMPLENAME}" #This submits an eager job with the current xml from the list
