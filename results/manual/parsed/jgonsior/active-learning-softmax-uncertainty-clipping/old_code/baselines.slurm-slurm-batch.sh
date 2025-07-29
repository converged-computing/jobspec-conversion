#!/bin/bash
#SBATCH --account=p_ml_il
#SBATCH --output=/scratch/ws/1/s5968580-btw/out-%A_%a.txt
#SBATCH --error=/scratch/ws/1/s5968580-btw/error-%A_%a.txt
#SBATCH --mail-user=julius.gonsior@tu-dresden.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=120GB
#SBATCH --time=23:59:59
#SBATCH --partition=alpha
#SBATCH --array=0-600

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE='./hf-cache'
export HF_DATASETS_CACHE='./hf-cache'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""
module load modenv/hiera  GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
module load PyTorch/1.10.0
source /scratch/ws/1/s5968580-btw/venv/bin/activate
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE="./hf-cache"
export HF_DATASETS_CACHE="./hf-cache"
mkdir -p $TRANSFORMERS_CACHE
python /scratch/ws/1/s5968580-btw/code/run_experiment.py --taurus --workload baselines --n_array_jobs 601 --array_job_id $SLURM_ARRAY_TASK_ID
exit 0
