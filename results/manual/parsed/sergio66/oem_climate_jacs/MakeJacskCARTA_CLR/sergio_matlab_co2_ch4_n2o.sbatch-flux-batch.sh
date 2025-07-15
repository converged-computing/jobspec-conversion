#!/bin/bash
#FLUX: --job-name=KCARTA_CO2JAC_DRIVER
#FLUX: --queue=high_mem
#FLUX: -t=3540
#FLUX: --priority=16

matlab -nodisplay -r "clust_make_ch4_1700_2000_all; clust_make_ch4_coljac_1700_2000; clust_make_ch4_coljac_1700_2000v2; exit"
matlab -nodisplay -r "clust_make_n2o_315_340_all; clust_make_n2o_coljac_315_340; clust_make_n2o_coljac_315_340v2; exit"
