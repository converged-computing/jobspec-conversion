#!/bin/bash
#FLUX: --job-name=verb_random_newsgroups_run # Όνομα για διαχωρισμό μεταξύ jobs
#FLUX: --queue=gpu
#FLUX: --priority=16

cd /users/pa21/ptzouv/tkaravangelis/mice_pos_newsgroups
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python3 /users/pa21/ptzouv/tkaravangelis/scripts/newsgroups_pos_random/run_verb_newsgroups.py
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
