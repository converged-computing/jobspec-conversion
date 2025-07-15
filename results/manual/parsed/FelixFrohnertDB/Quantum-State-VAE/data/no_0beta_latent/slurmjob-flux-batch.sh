#!/bin/bash
#FLUX: --job-name=phat-caramel-8897
#FLUX: -c=8
#FLUX: --queue=compIntel
#FLUX: -t=54000
#FLUX: --priority=16

module load QuantumMiniconda3/4.7.10
source /marisdata/frohnert/cluster/gen_dm/venv/bin/activate
size=1 
beta=0.0
noise="False"
for n_lat in 2
do
   srun python /home/frohnert/cluster/vae_4x4_mult.py $n_lat $size $beta $noise
done
