#!/bin/bash
#FLUX: --job-name=psycho-squidward-4786
#FLUX: --queue=thinkstation-p360
#FLUX: --urgency=16

srun matlab -nosplash -nodesktop -nodisplay -r "getting_h5; exit"
