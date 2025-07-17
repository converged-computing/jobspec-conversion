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
if [ ! -d "$TMPDIR/$USER/hn_delin" ]
    then
    echo "Didn't find dataset folder. Copying files..."
    mkdir --parents $TMPDIR/$USER/hn_delin
    fi
for f in $(ls /net/fs-1/Ngoc/depredict/*)
    do
    FILENAME=`echo $f | awk -F/ '{print $NF}'`
    echo $FILENAME
    if [ ! -f "$TMPDIR/$USER/hn_delin/$FILENAME" ]
        then
        echo "copying $f"
        cp -r /net/fs-1/Ngoc/depredict/$FILENAME $TMPDIR/$USER/hn_delin/
        fi
    done
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
singularity exec --nv deoxys-mar22-multi.sif python ensemble_outcome.py /net/fs-1/Ngoc/hnperf/$1 $2 ${@:3}
