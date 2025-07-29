#!/bin/bash
#FLUX: --job-name=SuMD_analysis
#FLUX: -n=5
#FLUX: -t=2400
#FLUX: --urgency=16

export PYTHONPATH='/home/pnavarro/.conda/envs/sumd_analyzer/lib/python3.10/site-packages/'
export PATH='/home/pnavarro/.conda/envs/sumd_analyzer/bin:$PATH'

module purge 
module load Miniconda3/4.9.2
module load VMD/1.9.4a57-intel-2021b
source activate /home/pnavarro/.conda/envs/sumd_analyzer
export PYTHONPATH=/home/pnavarro/.conda/envs/sumd_analyzer/lib/python3.10/site-packages/
export PATH=/home/pnavarro/.conda/envs/sumd_analyzer/bin:$PATH
INPUT_YML=input_analysis.yml
PATH_TO_SUMDANALYZER=/shared/work/BiobbWorkflows/src/biobb_workflows/Other/SuMD-analyzer
python $PATH_TO_SUMDANALYZER/RNASuMDAnalyzer.py geometry $INPUT_YML
python $PATH_TO_SUMDANALYZER/RNASuMDAnalyzer.py mmgbsa $INPUT_YML
python $PATH_TO_SUMDANALYZER/RNASuMDAnalyzer.py intEnergy $INPUT_YML
