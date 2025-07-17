#!/bin/bash
#FLUX: --job-name=goodbye-peanut-5488
#FLUX: --queue=long
#FLUX: -t=1209540
#FLUX: --urgency=16

module load python
module load python2/2.7.13
module load easybuild
module load GCC/6.3.0-2.27
module load OpenMPI/2.0.2
module load RepeatModeler/1.0.11
module load RepeatMasker/4.0.7
module load anaconda3/2019.07
conda activate transposon_annotation_tools_env
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool helitronScanner
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool mitefind
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool mitetracker
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool must
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool repeatmodel
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool repMasker
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool sinefind
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool sinescan
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool tirvish
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool transposonPSI
reasonaTE -mode annotate -projectFolder projectfolder -projectName projectname -tool NCBICDD1000
