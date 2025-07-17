#!/bin/bash
#FLUX: --job-name=narc
#FLUX: --queue=accel
#FLUX: -t=7200
#FLUX: --urgency=16

set -o errexit  # Recommended for easier debugging
source /etc/profile
module purge
module load PyTorch/1.9.0-fosscuda-2020b
python3 -m venv /fp/homes01/u01/ec-egilron/venvs/trans_nopt --clear
source /fp/homes01/u01/ec-egilron/venvs/trans_nopt/bin/activate
pip install jsonlines
pip install toml
pip install transformers==3.2.0
echo "Starting experiment POC_000" 
python wl-coref-ncc/run.py train POC_000 --config-file wl-coref-ncc/tomls/POC.toml
echo "Starting experiment POC_001" 
python wl-coref-ncc/run.py train POC_001 --config-file wl-coref-ncc/tomls/POC.toml
echo "Starting experiment POC_002" 
python wl-coref-ncc/run.py train POC_002 --config-file wl-coref-ncc/tomls/POC.toml
echo "Starting experiment POC_003" 
python wl-coref-ncc/run.py train POC_003 --config-file wl-coref-ncc/tomls/POC.toml
