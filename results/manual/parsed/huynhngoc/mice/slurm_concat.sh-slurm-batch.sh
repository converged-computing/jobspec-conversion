#!/bin/bash
#SBATCH --job-name=ensemble
#SBATCH --output=outputs/ensemble-%A.out
#SBATCH --error=outputs/ensemble-%A.out
#SBATCH --mail-user=ngochuyn@nmbu.no
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=orion
#SBATCH --constraint=avx2

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
nvidia-modprobe -u -c=0
singularity exec --nv deoxys.sif python ensemble_results.py $PROJECTS/KBT/mice/perf/$1 $2 --merge_name concat --mode concat
