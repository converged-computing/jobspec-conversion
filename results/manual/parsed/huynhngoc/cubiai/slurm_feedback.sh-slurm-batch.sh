#!/bin/bash
#SBATCH --job-name=CubiAI_feedback
#SBATCH --output=outputs/feedback-%A.out
#SBATCH --error=outputs/feedback-%A.out
#SBATCH --mail-user=sunniva.elisabeth.daae.steiro@nmbu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=32G

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
