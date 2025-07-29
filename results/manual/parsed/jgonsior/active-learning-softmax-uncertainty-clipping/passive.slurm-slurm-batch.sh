#!/bin/bash
#SBATCH --account=p_ml_il
#SBATCH --output=/beegfs/ws/1/s5968580-btw/logs/out-%A_%a.txt
#SBATCH --error=/beegfs/ws/1/s5968580-btw/logs/error-%A_%a.txt
#SBATCH --mail-user=julius.gonsior@tu-dresden.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=120GB
#SBATCH --time=5-03:59:59
#SBATCH --array=0-20

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE='./hf-cache'
export HF_DATASETS_CACHE='./hf-cache'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
OUTFILE=""
module load release/23.04  GCC/11.3.0  OpenMPI/4.1.4
module load PyTorch/1.12.1-CUDA-11.7.0
source /beegfs/ws/1/s5968580-btw/python-environments/btw-v3/bin/activate
export HF_MODULE_CACHE='./hf-cache'
export TRANSFORMERS_CACHE="./hf-cache"
export HF_DATASETS_CACHE="./hf-cache"
mkdir -p $TRANSFORMERS_CACHE
python /beegfs/ws/1/s5968580-btw/active-learning-softmax-uncertainty-clipping/run_experiment.py --taurus --workload passive --n_array_jobs 20 --array_job_id $SLURM_ARRAY_TASK_ID
exit 0
