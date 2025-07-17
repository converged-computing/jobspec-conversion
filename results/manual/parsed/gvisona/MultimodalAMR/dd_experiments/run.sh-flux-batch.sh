#!/bin/bash
#FLUX: --job-name=creamy-punk-1971
#FLUX: --queue=urtgen_24hrs
#FLUX: --urgency=16

dir=/massstorage/URT/GEN/BIO3/PRIV/Team/Diane/RESEARCH/Hackathon/October/DRIAMSB
longTable=/home/gallia/scratch/u230399/DRIAMS_combined_long_table.csv
fingerprints=/home/gallia/scratch/u230399/drug_fingerprints.csv
driam=B
drug=Cefepime
path=/home/gallia/scratch/u230399/DRIAMS-$driam/$drug/
export longTable fingerprints driam drug species path
cd  $dir
mkdir $path
module load R/3.5.1
module load EasyBuild
module load Python/3.7.4-GCCcore-8.3.0
python
time python data_utils.py
Rscript createInputData.R "$driam" "$drug" "$path"
time python SiameseNetworks.py
Rscript modelAndEvaluation.R "$driam" "$drug"
