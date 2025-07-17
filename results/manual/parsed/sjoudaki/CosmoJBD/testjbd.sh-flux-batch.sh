#!/bin/bash
#FLUX: --job-name=cosmomc
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ir=0
echo $ir > countjbd.txt
echo $ir > testjbd.txt
for ((bl=0; bl<=999; bl++)); do
cp data/lensingrsdfiles/bootstrapnz/nz_z1_kids_boot${bl}.dat data/lensingrsdfiles/nz_z1_kids_binned_bootstrap.dat
cp data/lensingrsdfiles/bootstrapnz/nz_z2_kids_boot${bl}.dat data/lensingrsdfiles/nz_z2_kids_binned_bootstrap.dat
cp data/lensingrsdfiles/bootstrapnz/nz_z3_kids_boot${bl}.dat data/lensingrsdfiles/nz_z3_kids_binned_bootstrap.dat
cp data/lensingrsdfiles/bootstrapnz/nz_z4_kids_boot${bl}.dat data/lensingrsdfiles/nz_z4_kids_binned_bootstrap.dat
ir=`echo "200*$bl"|bc`
fr=`echo "200*($bl+1)"|bc`
echo $bl >> countjbd.txt
echo $ir >> countjbd.txt
echo $fr >> countjbd.txt
sed -i "/samples/ s/${ir}/${fr}/" /home/sjoudaki/projects/rrg-wperciva/sjoudaki/CosmoJBD/batch1/common_batch1_jbd.ini
echo $SLURM_JOB_ID >> testjbd.txt
mpirun --map-by node --bind-to none -np 8 -x OMP_NUM_THREADS=8 ./cosmomc testjbd.ini >> testjbd.txt
done
echo finished
