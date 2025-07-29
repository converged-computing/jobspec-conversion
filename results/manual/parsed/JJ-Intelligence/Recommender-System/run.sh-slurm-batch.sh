#!/bin/bash
#SBATCH --mail-user=jp6g18@soton.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=56

export PYTHONPATH='${PYTHONPATH}:${SLURM_SUBMIT_DIR}/src/'

echo "Starting Job"
module load python/3.6.4
source venv/bin/activate
export PYTHONPATH="${PYTHONPATH}:${SLURM_SUBMIT_DIR}/src/"
python src/main.py tune --trainfile datasets/comp3208-train.csv --testfile datasets/comp3208-test.csv --outputfile predictions.csv
echo "Finishing job"
