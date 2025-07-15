#!/bin/bash
#FLUX: --job-name=TutorialJob
#FLUX: -c=4
#FLUX: --queue=test
#FLUX: -t=600
#FLUX: --urgency=16

singularity exec --nv ~/sdc_gym.simg python your_file.py
echo DONE!
