#!/bin/bash
#FLUX: --job-name=IAP_test
#FLUX: -n=32
#FLUX: -t=36000
#FLUX: --priority=16

eaddress="lei.zhang@rug.nl"
module restore set-gap
echo "Please input the name for current Potential"
potential_name="GAP_NNIP_R6.5"
mkdir ${potential_name}
LMMP="/home/zhanglei1/software/lammps/src/lmp_mpi"
Ncores=4
if [ -f results.txt ]
then
        rm results.txt
else
        echo "No results file is found!"
fi
touch results.txt
echo '===========================' | tee -a  results.txt
echo 'GAP basis set:' ${potential_name} | tee -a results.txt
awk '/^pair_style*/' ./potential.in | tee -a results.txt
awk '/^pair_coeff*/' ./potential.in | tee -a results.txt
echo '===========================' | tee -a results.txt
cd ENERGYVOLUME
mpirun -np 4 $LMMP -in in.eos 
python eos-fit.py
cp volume.dat ../PLOT_DATA/eos_gap_lei.csv
a1=$(grep 'a0 =' ../results.txt | awk '{print $3}')
echo 'EOS Generated!'
cd ../BAINPATH
rm slurm*
rm dump*
mpirun -np 2 $LMMP -in in.bain_path -v lat $a1
cd ../SFE
rm slurm*
rm dump*
mpirun -np 32 $LMMP -in in.bain_path -v lat $a1
mpirun -np 32 $LMMP -in in.bain_path -v lat $a1
cd ../VACANCY
mpirun -n 32 $LMMP -in in.vac -v lat $a1
cd ../ELASTIC
mpirun -n 32  $LMMP -in in.elastic -v lat $a1
cd ../SURFACEENERGY
rm log.* dump*
mpirun -n 32  $LMMP -in in.surf1 -v lat $a1
mv log.lammps log.surf100
mpirun -n 32 $LMMP -in in.surf2 -v lat $a1
mv log.lammps log.surf110
mpirun -n 32 $LMMP -in in.surf3 -v lat $a1
mv log.lammps log.surf111
mpirun -n 32 $LMMP -in in.surf4 -v lat $a1
mv log.lammps log.surf112
cd ..
mail -s "Basic Properties of iron predicted by IAP"  -a results.txt "${eaddress}" <<EOF
Please check the performance of interatomic potential: ${potential_name}
EOF
cd PLOT_DATA
python Plot_eos_bain.py
cp gap21_eos_bp.png ../${potential_name}
python sfe.py
cp sfe_110plane.png ../${potential_name}
cd ..
cp results.txt ${potential_name}
cp -r SFE ${potential_name}
cd ${potential_name}
mail -s "EOS, Bain path, and SFE of iron predicted by GAP:"  -a gap21_eos_bp.png -a sfe_110plane.png "${eaddress}" <<EOF
Please check the performance of GAP version:  ${potential_name}.
EOF
