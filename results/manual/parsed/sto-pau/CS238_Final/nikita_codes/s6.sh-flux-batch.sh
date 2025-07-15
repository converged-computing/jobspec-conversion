#!/bin/bash
#FLUX: --job-name=arid-pedo-8329
#FLUX: --priority=16

module purge
module load openmpi
module load anaconda3 
module load julia 
eval "$(conda shell.bash hook)"
conda activate env_CS238
cd /home/nkozak/CS238/explore_states
python3 s6.py
tail -n 1000 s6*.out > end_s6.out
rm s6*.out
cd /home/nkozak/CS238/explore_states/s6/backGround
rm -r 1*
rm -r 2*
rm -r 3*
rm -r 4*
rm -r 5*
rm -r 6*
rm -r 7*
rm -r 8*
rm -r 9*
rm -r processor*
zip -r VTK.zip VTK
rm -r VTK
zip -r postProcessing.zip postProcessing
rm -r postProcessing
mkdir /scratch/users/nkozak/CS238/explore_states/s6
mv /home/nkozak/CS238/explore_states/s6/backGround /scratch/users/nkozak/CS238/explore_states/s6/.
