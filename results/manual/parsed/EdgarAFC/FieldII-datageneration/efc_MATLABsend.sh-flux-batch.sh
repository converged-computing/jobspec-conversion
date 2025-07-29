#!/bin/bash
#FLUX --job-name=outstanding-cattywampus-1526
#FLUX --queue=thinkstation-p360
#FLUX --urgency=16

srun matlab -nosplash -nodesktop -nodisplay -r "getting_h5; exit"
