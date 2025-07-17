#!/bin/bash
#FLUX: --job-name=example-hpc-alpine-python
#FLUX: -n=4
#FLUX: --queue=amilan
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda/2022.10
conda env remove --name example_env -y
conda env create -f environment.yml
conda activate example_env
python code/example.py --CSV_FILENAME=$CSV_FILEPATH
echo "run_script.sh work finished!"
