#!/bin/bash
#FLUX: --job-name=pickle3_files
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python3 /users/pa21/ptzouv/tkaravangelis/scripts/create_news_pickle.py /users/pa21/ptzouv/tkaravangelis/polyjuice_results/new_news_verb newsgroups new_verb
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
