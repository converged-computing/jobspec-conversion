#!/bin/bash
#FLUX: --job-name=run_semanticParserShort
#FLUX: -c=28
#FLUX: -t=57600
#FLUX: --urgency=16

module load python/3.7-2019.10 cuda
echo "Loaded modules"
cd /users/PAS1372/osu10106/projects/foodshed/semantic_parsing_with_constrained_lm/
echo "Entered directory"
source $HOME/.poetry/env
echo "Sourced poetry"
bash runOvernight.sh
