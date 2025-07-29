#!/bin/bash
#SBATCH --job-name=polyomino
#SBATCH --output=/users/amaesumi/logs/polyomino%a.out
#SBATCH --error=/users/amaesumi/logs/polyomino%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6g
#SBATCH --time=1-00:00:00
#SBATCH --array=0-31

cd /users/amaesumi/pack_poly
module load anaconda/2022.05
module load gcc/10.2
source /gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh
conda activate systems
NUM_THREADS=32
python stability.py --stage preproc --nthreads $NUM_THREADS --thread_id $SLURM_ARRAY_TASK_ID
