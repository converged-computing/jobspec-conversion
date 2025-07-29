#!/bin/bash
#FLUX --job-name=frigid-cattywampus-9161
#FLUX -c=10
#FLUX --queue=small
#FLUX -t=1200
#FLUX --urgency=16

module load geoconda
python csc_stac_example.py
