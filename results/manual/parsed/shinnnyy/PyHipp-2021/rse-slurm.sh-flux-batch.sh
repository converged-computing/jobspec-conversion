#!/bin/bash
#FLUX: --job-name=fat-motorcycle-0491
#FLUX: -t=86400
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; \
import os; \
import time; \
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:600320627072:awsnotify --message "RSEJobDone"
