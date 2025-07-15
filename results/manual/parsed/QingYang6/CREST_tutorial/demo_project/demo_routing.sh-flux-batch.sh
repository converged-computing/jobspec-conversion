#!/bin/bash
#FLUX: --job-name=muffled-soup-4736
#FLUX: -t=3600
#FLUX: --priority=16

cd /mnt/permanent/hydro/src/CREST_3.0
matlab -nodisplay -nosplash -r "CREST('/mnt/training/crest/qing/CREST_tutorial/demo_project/demo.project','mean'); exit;"
