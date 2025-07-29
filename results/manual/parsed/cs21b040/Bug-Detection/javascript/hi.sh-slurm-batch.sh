#!/bin/bash
#SBATCH --job-name=SELAB
#SBATCH --output=/scratch/%u/%x-%N-%j.out
#SBATCH --error=/scratch/%u/%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000M
#SBATCH --time=05:00:00
#SBATCH --qos=mediumq

. /etc/profile.d/modules.sh
module load anaconda/2023.03-1
eval "$(conda shell.bash hook)"
conda activate /home1/cs21b052/.conda/envs/temp
python3 /scratch/cs21b052/SEProject/python2/BugLearn.py --pattern IncorrectAssignment --token_emb /scratch/cs21b052/SEProject/token_to_vector*.json --type_emb /scratch/cs21b052/SEProject/type_to_vector.json --node_emb /scratch/cs21b052/SEProject/node_type_to_vector.json --training_data /scratch/cs21b052/SEProject/assignments_train/*.json
conda deactivate
