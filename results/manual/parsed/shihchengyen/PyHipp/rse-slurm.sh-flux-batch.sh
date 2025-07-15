#!/bin/bash
#FLUX: --job-name=evasive-bike-0275
#FLUX: -t=86400
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; import time; import os; t0 = time.time(); print(time.localtime()); os.chdir('sessioneye'); pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); print(time.localtime()); print(time.time()-t0);"
