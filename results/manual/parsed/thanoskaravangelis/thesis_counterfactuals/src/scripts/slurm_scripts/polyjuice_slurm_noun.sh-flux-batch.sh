#!/bin/bash
#FLUX: --job-name=im_nou_polyjuice_run
#FLUX: --queue=gpu
#FLUX: --urgency=16

cd /users/pa21/ptzouv/tkaravangelis/mice
module purge
module load gnu/8 cuda/10.1.168 intelmpi/2018 pytorch/1.7.0
source /users/pa21/ptzouv/tkaravangelis/venv_polyjuice/bin/activate
start=$(date +%s.%N)
srun python ../scripts/polyjuice_with_pos2.py NOUN
deactivate
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Total script time $runtime"
