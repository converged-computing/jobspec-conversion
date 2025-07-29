#!/bin/bash
#SBATCH --job-name=UCI_Datarun
#SBATCH --mail-user=jpatsol1@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=24

if [[ "$USER" == "jpatsol1@jhu.edu" ]]; then
	export NCORES=$SLURM_NTASKS
	module load gcc/6.4.0
	module load python/3.7
	source ./env/bin/activate
	module load gcc/6.4.0
elif [[ "$USER" == "JLP" ]]; then
	#export SLURM_ARRAY_TASK_ID=117 #wine rerf
	#export SLURM_ARRAY_TASK_ID=238 #wine RF
	#export SLURM_ARRAY_TASK_ID=359 #wine SKRF
	#export SLURM_ARRAY_TASK_ID=480 #wine SKX
	export SLURM_ARRAY_TASK_ID=2 #abalone rerf
	export NCORES=1
fi
DATASET="$(awk '{print $1}' jobMap_filtered_numeric.dat | sed "$SLURM_ARRAY_TASK_ID q;d")"
CLASSIFIER="$(awk '{print $2}' jobMap_filtered_numeric.dat | sed "$SLURM_ARRAY_TASK_ID q;d")"
echo "DATASET=$DATASET	CLASSIFIER=$CLASSIFIER"
python run.py $DATASET $CLASSIFIER
