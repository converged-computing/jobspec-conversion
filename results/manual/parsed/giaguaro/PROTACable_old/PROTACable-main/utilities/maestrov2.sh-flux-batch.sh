#!/bin/bash
#FLUX: --job-name=stage1
#FLUX: --queue=normal
#FLUX: --urgency=16

i=$1
mkdir ../temp_process/${i%.*}_stg1res
rm ../temp_process/${i%.*}_stg1res/*
mv $i ../temp_process/${i%.*}_stg1res
cd ../temp_process/${i%.*}_stg1res
$SCHRODINGER/utilities/prepwizard -WAIT -NOJOBID -noepik -noimpref -rmsd 5.0 -f 3 -j stage1_${i%.*} ${i%.*}.pdb mae_${i%.*}.pdb
mv mae_${i%.*}.pdb ../../process/
mv ${i%.*}.pdb ../../process/
rm *
cd ../../process/ 
sbatch maestro3.sh mae_${i%.*}.pdb
