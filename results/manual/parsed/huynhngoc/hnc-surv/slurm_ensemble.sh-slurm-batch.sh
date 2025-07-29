#!/bin/bash
#SBATCH --job-name=ensemble
#SBATCH --output=outputs/ensemble-%A.out
#SBATCH --error=outputs/ensemble-%A.out
#SBATCH --mail-user=torjus.strandenes.moen@nmbu.no
#SBATCH --mail-type=FAIL
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
echo "Finished seting up files."
nvidia-modprobe -u -c=0
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
singularity exec --nv deoxys-survival.sif python ensemble_outcome.py $PROJECTS/ngoc/hn_surv/perf/$1 $2 ${@:3}
