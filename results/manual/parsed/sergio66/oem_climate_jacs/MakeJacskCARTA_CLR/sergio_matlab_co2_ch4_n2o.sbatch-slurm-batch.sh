#!/bin/bash
#SBATCH --job-name=KCARTA_CO2JAC_DRIVER
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=00:59:00
#SBATCH --partition=high_mem
#SBATCH --qos=short+

matlab -nodisplay -r "clust_make_ch4_1700_2000_all; clust_make_ch4_coljac_1700_2000; clust_make_ch4_coljac_1700_2000v2; exit"
matlab -nodisplay -r "clust_make_n2o_315_340_all; clust_make_n2o_coljac_315_340; clust_make_n2o_coljac_315_340v2; exit"
