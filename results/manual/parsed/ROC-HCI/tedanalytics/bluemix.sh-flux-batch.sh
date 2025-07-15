#!/bin/bash
#FLUX: --job-name=rainbow-malarkey-4610
#FLUX: --priority=16

module load anaconda
python -c "import bluemix;bluemix.process_bluehive()"
