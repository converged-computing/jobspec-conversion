#!/bin/bash
#FLUX: --job-name=XLMR_predict
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module purge   # Recommended for reproducibility
module load nlpl-python-candy/2021.01-foss-2019b-Python-3.7.4
module load nlpl-scikit-bundle/0.22.2.post1-foss-2019b-Python-3.7.4
bash run_xlmr_pred.sh
