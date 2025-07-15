#!/bin/bash
#FLUX: --job-name=stage4
#FLUX: --queue=normal
#FLUX: --priority=16

source ~/.bashrc
conda activate amber
m=$1
mkdir ../stg4/${m%.*}_results
rm ../stg4/${m%.*}_results/*
cp $m ../stg4/${m%.*}_results/
cd ../stg4/${m%.*}_results/
$SCHRODINGER/utilities/structconvert -ipdb $m -omae pv_${m%.*}.mae
$SCHRODINGER/run pv_convert.py pv_${m%.*}.mae -mode split_pv -lig_last_mol
$SCHRODINGER/prime_mmgbsa pv_${m%.*}-out_pv.mae -WAIT -NOJOBID -job_type SITE_OPT -target_flexibility -target_flexibility_cutoff 20 -out_type COMPLETE
$SCHRODINGER/utilities/structconvert -imae pv_${m%.*}-out-out.maegz -opdb pv_${m%.*}-out-out.pdb
mv *out-out* ../../process_4
echo "DONE MODELLING"
