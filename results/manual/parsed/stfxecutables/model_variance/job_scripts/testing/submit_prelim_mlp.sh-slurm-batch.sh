#!/bin/bash
#SBATCH --job-name=mlp_hps
#SBATCH --account=rrg-jlevman
#SBATCH --output=/scratch/dberger/model_variance/slurm_logs/mlp_hps_%A_%a_%j.out
#SBATCH --mail-user=dberger@stfx.ca
#SBATCH --mail-type=TIME_LIMIT_90
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=8000M
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-9

module load nixpkgs/16.09 intel/2018.3 fsl/6.0.1
SCRATCH="$(readlink -f "$SCRATCH")"
PROJECT="$SCRATCH/model_variance"
RUN_SCRIPT="$PROJECT/run_hperturbs.sh"
PY_SCRIPTS="$PROJECT/scripts"
PY_SCRIPT="$(readlink -f "$PY_SCRIPTS/script.py")"
bash "$RUN_SCRIPT"
