#!/bin/bash
#FLUX: --job-name=phat-peas-6497
#FLUX: -c=6
#FLUX: --queue=regular
#FLUX: -t=864000
#FLUX: --priority=16

module load Python/3.9.6-GCCcore-11.2.0
source $HOME/venvs/mystery/bin/activate
python3 main_buffer.py $1 10 &
python3 main_buffer.py $1 25 &
python3 main_buffer.py $1 50 &
python3 main_buffer.py $1 100 &
python3 main_buffer.py $1 200 &
python3 main_buffer.py $1 400
wait
module load git
git config --global user.email "michal.tesnar007@gmail.com"
git config --global user.name "MichalTesnar"
git add --a
git commit -m "$1 Buffer Fun"
git push
deactivate
