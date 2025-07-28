#!/bin/bash
#FLUX: --job-name=CubiAI_feedback
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: --urgency=16

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/$USER/ray'

module load singularity
if [ $# -lt 3 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
if [ ! -d "$TMPDIR/$USER/CubiAI" ]
    then
    echo "Didn't find dataset folder. Copying files..."
    mkdir --parents $TMPDIR/$USER/CubiAI
    fi
for f in $(ls $PROJECTS/ngoc/CubiAI/datasets/*)
    do
    FILENAME=`echo $f | awk -F/ '{print $NF}'`
    echo $FILENAME
    if [ ! -f "$TMPDIR/$USER/CubiAI/$FILENAME" ]
        then
        echo "copying $f"
        cp -r $PROJECTS/ngoc/CubiAI/datasets/$FILENAME $TMPDIR/$USER/CubiAI/
        fi
    done
echo "Finished setting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/$USER/ray
singularity exec --nv deoxys.sif python feedback_model.py $1 $PROJECTS/ngoc/CubiAI/perf/pretrain/$2 --temp_folder $SCRATCH_PROJECTS/ceheads/CubiAI/pretrain/$2 --epochs $3 ${@:4}
