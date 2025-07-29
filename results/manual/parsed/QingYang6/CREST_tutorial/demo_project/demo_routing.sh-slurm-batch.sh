#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

cd /mnt/permanent/hydro/src/CREST_3.0
matlab -nodisplay -nosplash -r "CREST('/mnt/training/crest/qing/CREST_tutorial/demo_project/demo.project','mean'); exit;"
