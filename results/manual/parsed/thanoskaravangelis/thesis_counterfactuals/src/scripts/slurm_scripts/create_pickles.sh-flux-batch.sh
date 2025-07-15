#!/bin/bash
#FLUX: --job-name=pickle_files
#FLUX: --queue=gpu
#FLUX: --urgency=16

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python3 /users/pa21/ptzouv/tkaravangelis/scripts/create_pickle_files.py /users/pa21/ptzouv/tkaravangelis/polyjuice_results/imdb_VERB imdb new_verb
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
