#!/bin/bash
#FLUX: --job-name=carnivorous-animal-4868
#FLUX: --queue=priority
#FLUX: -t=43200
#FLUX: --urgency=16

NX=1
NY=1
SIZEX=20.29
SIZEY=20.31
SIZEZ=402.1
MATERIAL=SciGlass-4-1-L
WRAPMATER=C10H8O4
PARTICLE=e-
ENERGIES=(3      3.25   3.5    3.75   4      4.25   4.5    4.75   5      5.25   5.5    5.75   6)
EVENTS=(  5000   5000   5000   5000   5000   5000   5000   5000   5000   5000   5000   5000   5000)
TEMPLATE_MACROS=./macros/slurm-eres-optical-template.mac
MACROS=./macros/eres-optical-${MATERIAL}-${NX}x${NY}-${SIZEX}x${SIZEY}x${SIZEZ}mm-${ENERGIES[$SLURM_ARRAY_TASK_ID]}GeV-${EVENTS[$SLURM_ARRAY_TASK_ID]}events.mac
source /site/12gev_phys/softenv.sh 2.6
cd /u/home/petrs/Development/glass-prototype-build/
cp ${TEMPLATE_MACROS} ${MACROS}
sed -i "s;_NX;${NX};g" ${MACROS}
sed -i "s;_NY;${NY};g" ${MACROS} 
sed -i "s;_SIZEX;${SIZEX};g" ${MACROS} 
sed -i "s;_SIZEY;${SIZEY};g" ${MACROS} 
sed -i "s;_SIZEZ;${SIZEZ};g" ${MACROS}
sed -i "s;_MATERIAL;${MATERIAL};g" ${MACROS}
sed -i "s;_WRAPMATER;${WRAPMATER};g" ${MACROS}
sed -i "s;_PARTICLE;${PARTICLE};g" ${MACROS}
sed -i "s;_EVENTS;${EVENTS[$SLURM_ARRAY_TASK_ID]};g" ${MACROS}
sed -i "s;_ENERGY;${ENERGIES[$SLURM_ARRAY_TASK_ID]};g" ${MACROS} 
./glass ${MACROS} 
