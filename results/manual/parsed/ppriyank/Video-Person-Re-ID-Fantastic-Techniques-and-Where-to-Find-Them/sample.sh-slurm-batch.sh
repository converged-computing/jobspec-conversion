#!/bin/bash
#FLUX: --job-name=pp1953
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --urgency=16

. ~/.bashrc
module load anaconda3/5.3.1
conda activate PPUU
conda install -n PPUU nb_conda_kernels
chikka=$1
echo $chikka
cd 
cd /home/pp1953/code/official
python config_trainer.py --focus=map --dataset=mars --opt=$chikka --name=_mars_cl_centers_ --cl-centers >>  ~/code/official/output/mars_cl_centers_$chikka.out
