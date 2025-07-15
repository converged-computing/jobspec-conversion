#!/bin/bash
#FLUX: --job-name=KCARTA_CLRJANOM_DRIVER
#FLUX: --queue=high_mem
#FLUX: -t=3540
#FLUX: --priority=16

matlab -singleCompThread -nodisplay -r "clust_do_kcarta_driver_anomaly_filelist; exit"
