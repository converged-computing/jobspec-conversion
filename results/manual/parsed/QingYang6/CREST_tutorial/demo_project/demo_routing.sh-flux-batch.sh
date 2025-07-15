#!/bin/bash
#FLUX: --job-name=red-rabbit-5412
#FLUX: -t=3600
#FLUX: --urgency=16

cd /mnt/permanent/hydro/src/CREST_3.0
matlab -nodisplay -nosplash -r "CREST('/mnt/training/crest/qing/CREST_tutorial/demo_project/demo.project','mean'); exit;"
