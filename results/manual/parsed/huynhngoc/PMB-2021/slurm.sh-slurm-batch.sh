#!/bin/bash
#FLUX: --job-name=hn_unet
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load singularity
if [ $# -lt 3 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
if [ ! -d "$TMPDIR/hn_delin" ]
    then
    echo "Didn't find dataset folder. Copying files..."
    mkdir $TMPDIR/hn_delin
    fi
for f in $(ls $HOME/datasets/headneck/*)
    do
    FILENAME=`echo $f | awk -F/ '{print $NF}'`
    echo $FILENAME
    if [ ! -f "$TMPDIR/hn_delin/$FILENAME" ]
        then
        echo "copying $f"
        cp -r $HOME/datasets/headneck/$FILENAME $TMPDIR/hn_delin/
        fi
    done
echo "Finished seting up files."
nvidia-modprobe -u -c=0
singularity exec --nv $HOME/sif/deoxys.sif python experiment.py $1 $HOME/unet/$2 --epochs $3 ${@:4}
