#!/bin/bash
#FLUX: --job-name=expensive-chip-4233
#FLUX: --priority=16

module load Anaconda3/5.0.1-fasrc01
python -c "import datetime; print(\"Date and time is: \" + str(datetime.datetime.now()))"
