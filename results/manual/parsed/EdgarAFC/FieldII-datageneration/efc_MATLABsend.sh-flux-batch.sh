#!/bin/bash
#FLUX: --job-name=muffled-omelette-3056
#FLUX: --queue=thinkstation-p360
#FLUX: --priority=16

srun matlab -nosplash -nodesktop -nodisplay -r "getting_h5; exit"
