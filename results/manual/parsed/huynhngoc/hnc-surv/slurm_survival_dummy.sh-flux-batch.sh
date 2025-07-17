#!/bin/bash
#FLUX: --job-name=survival
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: --urgency=16

export MAX_SAVE_STEP_GB='0'
export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'

module load singularity
if [ $# -lt 3 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export MAX_SAVE_STEP_GB=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
singularity exec --nv deoxys-survival.sif python experiment_survival_dummy.py $1 $PROJECTS/ngoc/hn_surv/perf/$2 --temp_folder $SCRATCH_PROJECTS/ceheads/hn_surv/$2 --analysis_folder $SCRATCH_PROJECTS/ceheads/hn_surv_analysis/$2 --epochs $3 ${@:4}
