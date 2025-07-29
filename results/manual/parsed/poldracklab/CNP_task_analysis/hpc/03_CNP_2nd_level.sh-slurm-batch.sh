#!/bin/bash
#SBATCH --output=logs/CNP.group.%a.txt
#SBATCH --error=logs/CNP.group.%a.txt
#SBATCH --mail-user=joke.durnez@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=10:00:00

source $HOME/CNP_analysis/config.sh
unset PYTHONPATH
if [ ! -f $SINGULARITY ]; then
    echo "Singularity container for analyses not found!  Please first create singularity container."
fi
singularity exec $SINGULARITY echo "Analyis '${SLURM_ARRAY_TASK_ID}' started"
cd $HOMEDIR
set -e
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" $HOMEDIR/hpc/group_tasks.txt )
echo "༼ つ ◕_◕ ༽つ CNP modeling pipeline finished"
