#!/bin/bash
#FLUX: --job-name=delicious-hope-2381
#FLUX: -c=12
#FLUX: --queue=thinkstation-p360
#FLUX: --priority=16

matlab -nosplash -nodesktop -nodisplay -r "gendata_w10; exit"
