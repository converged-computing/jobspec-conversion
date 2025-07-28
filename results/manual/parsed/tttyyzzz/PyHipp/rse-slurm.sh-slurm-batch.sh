#!/bin/bash
#FLUX: --job-name=rse
#FLUX: -t=86400
#FLUX: --urgency=16

<<<<<<< HEAD
python -u -c "import PyHipp as pyh; \
import time; \
import os; \
=======
python -u -c "import PyHipp as pyh; \
import os; \
import time; \
>>>>>>> upstream/main
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:717393468782:awsnotify --message "RSEJobDone"
