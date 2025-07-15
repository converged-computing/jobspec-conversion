#!/bin/bash
#FLUX: --job-name=strawberry-leader-9892
#FLUX: -n=5
#FLUX: -t=86400
#FLUX: --urgency=16

python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; import time; import os; t0 = time.time(); print(time.localtime()); DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(33,65)]); DPT.objects.processDirs(dirs=['sessioneye/array02','session01/array02'], cmd='import PyHipp as pyh; import DataProcessingTools as DPT; DPT.objects.processDirs(None, pyh.RPLLFP, saveLevel=1); DPT.objects.processDirs(None, pyh.RPLHighPass, saveLevel=1);'); os.chdir('session01/array02'); DPT.objects.processDirs(level='channel', cmd='import PyHipp as pyh; from PyHipp import mountain_batch; mountain_batch.mountain_batch(); from PyHipp import export_mountain_cells; export_mountain_cells.export_mountain_cells();'); print(time.localtime()); print(time.time()-t0);"
