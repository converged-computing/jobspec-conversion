#!/bin/bash
#FLUX: --job-name=lovable-nalgas-7589
#FLUX: -c=12
#FLUX: --queue=thinkstation-p360
#FLUX: --urgency=16

matlab -nosplash -nodesktop -nodisplay -r "gendata_w10; exit"
