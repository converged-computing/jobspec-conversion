#!/bin/bash
#FLUX: --job-name=fgsa-dev
#FLUX: --queue=accel
#FLUX: -t=37800
#FLUX: --priority=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/1.7.1-foss-2019b-cuda-11.1.1-Python-3.7.4
module load nlpl-scikit-bundle/0.22.2.post1-foss-2019b-Python-3.7.4
module load nlpl-tokenizers/0.10.2-foss-2019b-Python-3.7.4
cd $HOME/nlp/msc/fgsa/src
python dev.py
