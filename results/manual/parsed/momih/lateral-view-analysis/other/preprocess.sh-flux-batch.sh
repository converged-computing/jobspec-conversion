#!/bin/bash
#FLUX: --job-name=lovely-pastry-6965
#FLUX: -t=3600
#FLUX: --priority=16

DATADIR=/lustre04/scratch/cohenjos/PC/images-224/
LABELSDIR=$HOME/projects/rpp-bengioy/jpcohen/PADCHEST_SJ/labels_csv/
source $HOME/homer/bin/activate
cd ~/works/lateral-view-analysis/
python extract_cohort.py --input_csv $LABELSDIR/PADCHEST_chest_x_ray_images_labels_160K_01.02.19.csv \
--output_csv $LABELSDIR/PA_only.csv --datadir $DATADIR --broken-file $LABELSDIR/broken_images \
--mode 'pa' --joint-csv $LABELSDIR/joint_PA_L.csv 
