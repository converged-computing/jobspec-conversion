#!/bin/bash
#FLUX: --job-name=TensorFlow
#FLUX: --queue=serial_requeue
#FLUX: -t=360
#FLUX: --urgency=16

module load Anaconda3/5.0.1-fasrc01
python -c "import datetime; print(\"Date and time is: \" + str(datetime.datetime.now()))"
