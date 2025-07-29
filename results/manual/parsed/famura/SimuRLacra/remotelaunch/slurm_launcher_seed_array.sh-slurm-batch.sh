#!/bin/bash
#SBATCH --job-name=seed_array_cpu
#SBATCH --output=/home/muratore/Software/SimuRLacra/remotelaunch/logs/%A_%a-out.txt
#SBATCH --error=/home/muratore/Software/SimuRLacra/remotelaunch/logs/%A_%a-err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=3-00:00:00
#SBATCH --array=0-19

echo "Starting Job $SLURM_JOB_ID, Array Job $SLURM_ARRAY_JOB_ID Index $SLURM_ARRAY_TASK_ID"
eval "$($HOME/Software/anaconda3/bin/conda shell.bash hook)"
conda activate pyrado
SIMURLACRA_DIR="$HOME/Software/SimuRLacra"
SCRIPTS_DIR="$SIMURLACRA_DIR/Pyrado/scripts"
cd "$SCRIPTS_DIR"
CMD="$@" # all arguments for the script call starting from PATHTO/SimuRLacra/Pyrado/scripts (excluding "python")
python $CMD --seed $SLURM_ARRAY_TASK_ID
