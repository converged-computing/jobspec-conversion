#!/bin/bash
#FLUX: --job-name=head_neck
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: --urgency=16

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'

module load singularity
if [ $# -lt 3 ];
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
singularity exec --nv deoxys-2023-feb-fixed.sif python experiment_outcome.py $1 $PROJECTS/ngoc/hnperf/$2 --temp_folder $SCRATCH_PROJECTS/ceheads/hnperf/$2 --analysis_folder $SCRATCH_PROJECTS/ceheads/hnperf_analysis/$2 --epochs $3 ${@:4}
