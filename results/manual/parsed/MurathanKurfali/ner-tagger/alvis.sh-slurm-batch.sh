#!/bin/bash
#SBATCH --account=NAISS2023-22-1238
#SBATCH --output=log-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load CUDA/12.3.0
module load Python/3.11.3-GCCcore-12.3.0
source rise_env/bin/activate
e.g ./run.sh --system-type $1 --bert-name $2
