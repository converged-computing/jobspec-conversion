#!/bin/bash
#FLUX: --job-name=bmix_mtanveer
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --urgency=16

module load anaconda
python -c "import bluemix;bluemix.process_bluehive()"
