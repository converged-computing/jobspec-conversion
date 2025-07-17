#!/bin/bash
#FLUX: --job-name=interpret
#FLUX: --queue=gpu
#FLUX: --urgency=16

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'
export MAX_SAVE_STEP_GB='0'

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
if [ ! -d "$TMPDIR/$USER/hn_delin" ]
    then
    echo "Didn't find dataset folder. Copying files..."
    mkdir --parents $TMPDIR/$USER/hn_delin
    fi
for f in $(ls $PROJECTS/ngoc/datasets/headneck/*)
    do
    FILENAME=`echo $f | awk -F/ '{print $NF}'`
    echo $FILENAME
    if [ ! -f "$TMPDIR/$USER/hn_delin/$FILENAME" ]
        then
        echo "copying $f"
        cp -r $PROJECTS/ngoc/datasets/headneck/$FILENAME $TMPDIR/$USER/hn_delin/
        fi
    done
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
export MAX_SAVE_STEP_GB=0
rm -rf $TMPDIR/ray/*
singularity exec --nv deoxys-2023-feb-fixed.sif python interpretability.py $1 $PROJECTS/ngoc/outcome_model/$2 --temp_folder $SCRATCH_PROJECTS/ceheads/hnperf/$2 --analysis_folder $SCRATCH_PROJECTS/ceheads/hnperf_analysis/$2 ${@:3}
