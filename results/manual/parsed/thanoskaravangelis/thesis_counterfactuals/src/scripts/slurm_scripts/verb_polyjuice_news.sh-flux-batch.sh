#!/bin/bash
#FLUX: --job-name=news_verb_poly
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv_polyjuice/bin/activate
start=$(date +%s.%N)
srun python3 ../scripts/polyjuice_newsgroups.py VERB
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
