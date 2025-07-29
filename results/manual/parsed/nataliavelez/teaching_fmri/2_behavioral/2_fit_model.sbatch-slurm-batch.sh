#!/bin/bash
#SBATCH --output=reports/fit_%x_%A_%a.out
#SBATCH --error=reports/fit_%x_%A_%a.err
#SBATCH --mail-user=nvelez@fas.harvard.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=01:00:00

module load ncf
module load Anaconda/5.0.1-fasrc01
source activate py3
if [[ $1 == 11 ]]; then
    echo "No free parameters; using deterministic method"
    python 2_fit_strong_model.py ${SLURM_ARRAY_TASK_ID}
else
    echo "Fitting model using scipy.optimize"
    python 2_fit_model.py ${SLURM_ARRAY_TASK_ID} $1
fi
