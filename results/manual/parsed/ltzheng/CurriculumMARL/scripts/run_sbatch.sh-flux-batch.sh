#!/bin/bash
#FLUX: --job-name=peachy-dog-8311
#FLUX: -c=128
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

algo=$1
teacher=$2
echo "Run module"
module load Singularity-CE/3.8.4
singularity instance start --nv -B /project/home/p200009/rundong:/home/rundong football.simg football
singularity exec -H /project/home/p200009/rundong:/home/rundong instance://football bash /home/rundong/football-invariant_att_com/run_football_in_singularity.sh ${algo} ${teacher}
