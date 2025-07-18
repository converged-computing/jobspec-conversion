#!/bin/bash
#FLUX: --job-name=kimCB_TU
#FLUX: --queue=long
#FLUX: -t=1209540
#FLUX: --urgency=16

module load python3/3.7.5
module load python2/2.7.13
module load easybuild
module load GCC/6.3.0-2.27
module load OpenMPI/2.0.2
module load RepeatModeler/1.0.11
module load RepeatMasker/4.0.7
module load anaconda3/2019.07
conda activate transposon_annotation_tools_env
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool helitronScanner
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool mitefind
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool mitetracker
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool must
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool repeatmodel
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool repMasker
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool sinefind
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool sinescan
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool tirvish
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool transposonPSI
reasonaTE -mode annotate -projectFolder kim_cb -projectName kim_cb1 -tool NCBICDD1000
