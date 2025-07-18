#!/bin/bash
#FLUX: --job-name=s2
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load openmpi
module load anaconda3 
module load julia 
eval "$(conda shell.bash hook)"
conda activate env_CS238
cd /home/nkozak/CS238/explore_states
python3 s2.py
tail -n 1000 s2*.out > end_s2.out
rm s2*.out
cd /home/nkozak/CS238/explore_states/s2/backGround
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
mkdir /scratch/users/nkozak/CS238/explore_states/s2
mv /home/nkozak/CS238/explore_states/s2/backGround /scratch/users/nkozak/CS238/explore_states/s2/.
