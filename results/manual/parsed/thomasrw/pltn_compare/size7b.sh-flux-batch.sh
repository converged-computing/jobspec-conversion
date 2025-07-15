#!/bin/bash
#FLUX: --job-name=chunky-soup-4002
#FLUX: --queue=defq-48core
#FLUX: --urgency=16

export SUMO_HOME='/work/apps/sumo/share/sumo'

module load sumo
module load python3/anaconda/2019.03
export SUMO_HOME=/work/apps/sumo/share/sumo
SIZE="7"
PERCENT=$(printf "%03d" $SLURM_ARRAY_TASK_ID)
j="100"
k="100"
l="100"
while [ $j -lt 200 ]
do
i="0"
while [ $i -lt 10 ]
do
/work/thoma525/main.py CAV$PERCENT"_${j}""_${SIZE}" /work/thoma525/demand/CAV$PERCENT"_${j}" $SIZE /work/thoma525/demand/ /work/thoma525/ /home/thoma525/myconfig /home/thoma525/mysimpla.cfg.xml /home/thoma525/myOUT-route.xml /home/thoma525/detPOI_OUT.xml /home/thoma525/valCount.xml --nogui
j=$((j + 1))
i=$((i + 1))
done
wait
i="0"
while [ $i -lt 10 ]
do
python3 /work/thoma525/eval_3.py CAV$PERCENT $k CAV$PERCENT"_size_${SIZE}" $SIZE &
k=$((k + 1))
i=$((i + 1))
done
wait
while [ $l -lt $j ]
do
rm /work/thoma525/CAV$PERCENT"_${l}""_${SIZE}""_tripinfo"
rm /work/thoma525/demand/CAV$PERCENT"_${l}""_${SIZE}""_platoon_status.xml"
rm /work/thoma525/CAV$PERCENT"_${l}""_${SIZE}""_validation_dets.xml"
l=$((l + 1))
done
rm /work/thoma525/CAV$PERCENT"_${j}""_${SIZE}""_tripinfo"
rm /work/thoma525/demand/CAV$PERCENT"_${j}""_${SIZE}""_platoon_status.xml"
rm /work/thoma525/CAV$PERCENT"_${j}""_${SIZE}""_validation_dets.xml"
done
echo success $SLURM_ARRAY_TASK_ID
