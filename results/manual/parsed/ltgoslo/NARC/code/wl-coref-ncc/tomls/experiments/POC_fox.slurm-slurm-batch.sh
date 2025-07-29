#!/bin/bash
#SBATCH --job-name=narc
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100:1
#SBATCH --mem=32G
#SBATCH --time=02:00:00

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
