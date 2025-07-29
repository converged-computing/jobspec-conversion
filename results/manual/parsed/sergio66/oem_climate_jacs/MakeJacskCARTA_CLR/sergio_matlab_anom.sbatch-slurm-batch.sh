#!/bin/bash
#SBATCH --job-name=KCARTA_CLRJANOM_DRIVER
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=00:59:00
#SBATCH --partition=high_mem
#SBATCH --qos=short+

matlab -singleCompThread -nodisplay -r "clust_do_kcarta_driver_anomaly_filelist; exit"
