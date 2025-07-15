#!/bin/bash
#FLUX: --job-name=rainbow-pot-9472
#FLUX: --urgency=16

module load anaconda
python -c "import bluemix;bluemix.process_bluehive()"
