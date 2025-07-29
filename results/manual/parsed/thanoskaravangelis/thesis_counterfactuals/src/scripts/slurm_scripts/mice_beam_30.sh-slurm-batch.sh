#!/bin/bash
#FLUX: --job-name=beam30_imdb
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

cd /users/pa21/ptzouv/tkaravangelis/mice_grad
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python3 /users/pa21/ptzouv/tkaravangelis/scripts/run_mice_beam_30.py
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
