#!/bin/bash
#FLUX: --job-name=ensemble
#FLUX: --queue=smallmem
#FLUX: --urgency=16

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
singularity exec --nv deoxys-survival.sif python ensemble_outcome.py $PROJECTS/ngoc/hn_surv/perf/$1 $2 ${@:3}
