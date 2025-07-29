#!/bin/bash
#FLUX --job-name=bumfuzzled-general-8055
#FLUX -c=12
#FLUX --queue=thinkstation-p360
#FLUX --urgency=16

matlab -nosplash -nodesktop -nodisplay -r "gendata_w10; exit"
