#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-11:00:00
#SBATCH --qos=regular
#SBATCH --constraint=haswell

module load tensorflow/intel-2.2.0-py37
python /global/homes/h/helenqu/scone/create_heatmaps.py --config_path  /global/homes/h/helenqu/scone/config/snoopy_config.yml
