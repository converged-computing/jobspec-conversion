#!/bin/bash
#FLUX: --job-name=confused-peanut-5930
#FLUX: --urgency=16

ml unload xalt
ml tacc-singularity
module list
if [[ -x "mspass_setup.sh"  ]]
then
    echo "the setup file is read "
else
    echo "the setup file is not executable"
    chmod +x mspass_setup.sh
fi
source mspass_setup.sh
cd $MSPASS_WORK_DIR
if [ 1$#==1 ]; then
  notebook_file=$1
else
  while getopts "b:" flag
    do
        case "${flag}" in
            b) notebook_file=${OPTARG};
        esac
    done
fi
echo Running $notebook_file
if [[ -x "$MSPASS_RUNSCRIPT"  ]]
then
    echo "$MSPASS_RUNSCRIPT is ready"
else
    echo "$MSPASS_RUNSCRIPT is not executable"
    chmod +x $MSPASS_RUNSCRIPT
fi
$MSPASS_RUNSCRIPT $notebook_file
