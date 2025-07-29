#!/bin/bash
#SBATCH --job-name=llm-attacks
#SBATCH --account=sail
#SBATCH --output=gcg_multiple.out
#SBATCH --error=gcg_multiple.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=7-00:00:00
#SBATCH --partition=sail

module load gcc/9.2 cmake python3/3.10 cuda/11.7
source ../../.venv/bin/activate
INITIALTIME=$(date)
echo "The initial time is " $INITIALTIME
bash run_gcg_multiple.sh llama2
FINALTIME=$(date)
echo "Finished at " $FINALTIME
echo "Elapsed time is " $FINALTIME-$INITIALTIME
