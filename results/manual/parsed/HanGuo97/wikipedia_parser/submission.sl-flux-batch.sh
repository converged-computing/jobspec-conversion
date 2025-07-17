#!/bin/bash
#FLUX: --job-name=peachy-destiny-6270
#FLUX: --queue=general
#FLUX: -t=7200
#FLUX: --urgency=16

module load python
pip3 install -r requirements.txt --user
python3 sentiAnalysis.py --wikiModelDir . --trainDataDir trainData --dataFileList dataFileArray/dataFileArray$SLURM_ARRAY_TASK_ID.txt --dataFileDir PARSED
