#!/bin/bash
#FLUX: --job-name=LegalReasoning
#FLUX: --queue=small
#FLUX: --priority=16

module load cuda/9.2
echo $PWD
python3 LanguageModel.py
