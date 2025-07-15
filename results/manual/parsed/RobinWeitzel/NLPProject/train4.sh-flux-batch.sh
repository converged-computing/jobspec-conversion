#!/bin/bash
#FLUX: --job-name=wobbly-lettuce-1955
#FLUX: --priority=16

module load python/3.6.3
module load gcc-7.1.0
python -m allennlp.run train training_config/bidaf_elmo_dropout.jsonnet -s output_elmo_dropout -f
