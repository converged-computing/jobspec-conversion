#!/bin/bash
#FLUX: --job-name=SELAB
#FLUX: -n=3
#FLUX: --queue=mediumq
#FLUX: -t=18000
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
module load anaconda/2023.03-1
eval "$(conda shell.bash hook)"
conda activate /home1/cs21b052/.conda/envs/temp
python3 /scratch/cs21b052/SEProject/python2/BugLearn.py --pattern IncorrectAssignment --token_emb /scratch/cs21b052/SEProject/token_to_vector*.json --type_emb /scratch/cs21b052/SEProject/type_to_vector.json --node_emb /scratch/cs21b052/SEProject/node_type_to_vector.json --training_data /scratch/cs21b052/SEProject/assignments_train/*.json
conda deactivate
