#!/bin/bash
#FLUX: --job-name=ensemble
#FLUX: --queue=orion
#FLUX: --urgency=16

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
nvidia-modprobe -u -c=0
singularity exec --nv deoxys.sif python ensemble_results.py $PROJECTS/KBT/mice/perf/$1 $2 --merge_name concat --mode concat
