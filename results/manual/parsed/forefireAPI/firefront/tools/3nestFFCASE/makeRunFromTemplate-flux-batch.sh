#!/bin/bash
#FLUX: --job-name=cowy-mango-1752
#FLUX: -n=20
#FLUX: --exclusive
#FLUX: --queue=intel
#FLUX: -t=72000
#FLUX: --priority=16

echo "SCRIPT RUN_PGD EN COURS"
template=$1
mydate=$2
cp -r $template $template$mydate
cd $template$mydate
cd 001_pgd
bash RUN_PGD PRE_PGD1.nam_2000m
bash RUN_PGD PRE_PGD1.nam_400m
bash RUN_PGD PRE_PGD1.nam_80m
bash RUN_PGDNEST
cd ../002_real
cp /data/filippi_j/saphir/data/ecmwfFC/$mydate/*grib* .
$PATCHER les gribs en ajoutant la neige et tout
bash RUN_REAL
cd ../003_run/
sbatch RUN_MESONH_120p
