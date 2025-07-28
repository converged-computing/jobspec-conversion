#!/bin/bash
#FLUX: --job-name=rse
#FLUX: -t=86400
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; import time; import os; t0 = time.time(); print(time.localtime()); os.chdir('sessioneye'); pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); print(time.localtime()); print(time.time()-t0);"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:532875939626:awsnotify --message "RSEJobDone"
