#!/bin/bash
#FLUX: --job-name=eccentric-malarkey-1790
#FLUX: --queue=urtgen_24hrs
#FLUX: --urgency=16

dir=/home/
longTable=/home/DRIAMS_combined_long_table.csv
driam=B
path=/home/
export longTable driam path
cd  $dir
module load R/3.5.1
module load EasyBuild
module load Python/3.7.4-GCCcore-8.3.0
python
Rscript createInputData_baseline.R "$driam" "$path"
Rscript createInputData_siamese.R "$driam" "$path"
Rscript baseline_species.R
time python similarity_baseline.py
time python similarity_baseline_truncated.py
time python SiameseNetworks.py
Rscript siamese_outputFormat.R
Rscript modelAndEvaluation.R
