#!/bin/bash
#SBATCH --job-name=ensemble
#SBATCH --output=outputs/ensemble-%A.out
#SBATCH --error=outputs/ensemble-%A.out
#SBATCH --mail-user=ngochuyn@nmbu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G

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
for f in $(ls $HOME/datasets/headneck/*)
    do
    FILENAME=`echo $f | awk -F/ '{print $NF}'`
    echo $FILENAME
    if [ ! -f "$TMPDIR/$USER/hn_delin/$FILENAME" ]
        then
        echo "copying $f"
        cp -r $HOME/datasets/headneck/$FILENAME $TMPDIR/$USER/hn_delin/
        fi
    done
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
singularity exec --nv deoxys-mar22-new.sif python ensemble_outcome.py /net/fs-1/Ngoc/hnperf/$1 $2 ${@:3}
