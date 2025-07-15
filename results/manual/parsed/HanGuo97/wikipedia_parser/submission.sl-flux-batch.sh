#!/bin/bash
#FLUX: --job-name=muffled-leopard-2457
#FLUX: --priority=16

module load python
pip3 install -r requirements.txt --user
python3 sentiAnalysis.py --wikiModelDir . --trainDataDir trainData --dataFileList dataFileArray/dataFileArray$SLURM_ARRAY_TASK_ID.txt --dataFileDir PARSED
