#!/bin/bash
#SBATCH --job-name=predictions
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=samuel.fraiberger@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=60GB
#SBATCH --time=1-00:00:00

module purge
module load anaconda3/2020.02
source ~/mypython/py3.7/bin/activate
cd /scratch/spf248/twitter
srun time python -u ./py/7.9-get-predictions-from-BERT.py > ./log/7.9-get-predictions-from-BERT-${SLURM_ARRAY_TASK_ID}-$(date +%s).log 2>&1
exit
