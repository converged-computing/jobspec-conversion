#!/bin/bash
#SBATCH --account=NAISS2024-22-380
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=alvis

module load SciPy-bundle/2022.05-foss-2022a
module load PyTorch-bundle/1.13.1-foss-2022a-CUDA-11.7.0
source ../my_python/bin/activate
python rac/run_experiments.py --config configs/ablation_fast/experiment$SLURM_ARRAY_TASK_ID.json
