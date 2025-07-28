#!/bin/bash
#FLUX: --job-name=cowy-peas-8088
#FLUX: -c=12
#FLUX: --queue=thinkstation-p360
#FLUX: --urgency=16

matlab -nosplash -nodesktop -nodisplay -r "gendata_w10; exit"
