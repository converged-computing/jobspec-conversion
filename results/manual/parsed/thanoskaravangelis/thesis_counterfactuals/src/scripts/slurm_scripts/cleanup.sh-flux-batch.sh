#!/bin/bash
#FLUX: --job-name=cleanup # Όνομα για διαχωρισμό μεταξύ jobs
#FLUX: --queue=gpu
#FLUX: --priority=16

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv/bin/activate
start=$(date +%s.%N)
srun python /users/pa21/ptzouv/tkaravangelis/cleanup.py
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
