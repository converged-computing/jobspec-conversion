#!/bin/bash
#FLUX: --job-name=fat-bike-0329
#FLUX: --queue=thinkstation-p360
#FLUX: --urgency=16

srun matlab -nosplash -nodesktop -nodisplay -r "getting_h5; exit"
