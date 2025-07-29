#!/bin/bash
#SBATCH --job-name=interpret_analyze
#SBATCH --output=outputs/interpret-analyze-%A-%a.out
#SBATCH --error=outputs/interpret-analyze-%A-%a.out
#SBATCH --mail-user=ngochuyn@nmbu.no
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --partition=smallmem,hugemem,orion,hugemem-avx2
#SBATCH --exclude=cn-11,cn-12,cn-14

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'
export MAX_SAVE_STEP_GB='0'

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
if [ ! -d "$PROJECTS/ngoc/hn_surv/perf/$2/OUS/smoothen_v2" ]
    then
    echo "Didn't find OUS smoothen result folder. Creating folder..."
    mkdir --parents $PROJECTS/ngoc/hn_surv/perf/$2/OUS/smoothen_v2
    fi
if [ ! -d "$PROJECTS/ngoc/hn_surv/perf/$2/MAASTRO/smoothen_v2" ]
    then
    echo "Didn't find MAASTRO smoothen result folder. Creating folder..."
    mkdir --parents $PROJECTS/ngoc/hn_surv/perf/$2/MAASTRO/smoothen_v2
    fi
echo "Finished seting up files."
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
export MAX_SAVE_STEP_GB=0
singularity exec --nv deoxys-survival.sif python -u interpret_analyze.py $1 $PROJECTS/ngoc/hn_surv/perf/$2 --idx $SLURM_ARRAY_TASK_ID
