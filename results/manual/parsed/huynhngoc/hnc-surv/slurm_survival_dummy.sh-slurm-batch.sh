#!/bin/bash
#SBATCH --job-name=survival
#SBATCH --output=outputs/surv-%A.out
#SBATCH --error=outputs/surv-%A.out
#SBATCH --mail-user=torjus.strandenes.moen@nmbu.no
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=100G

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
