#!/bin/bash
#FLUX: --job-name=psycho-peanut-butter-5506
#FLUX: -t=126000
#FLUX: --urgency=16

module load tensorflow/intel-2.2.0-py37
python /global/homes/h/helenqu/scone/create_heatmaps.py --config_path  /global/homes/h/helenqu/scone/config/snoopy_config.yml
