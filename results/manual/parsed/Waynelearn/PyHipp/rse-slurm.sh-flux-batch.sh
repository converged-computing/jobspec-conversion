#!/bin/bash
#FLUX: --job-name=eccentric-squidward-4829
#FLUX: -t=3600
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; \
import time; \
import os; \
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:064666353788:awsnotify --message "RSEJobDone"
