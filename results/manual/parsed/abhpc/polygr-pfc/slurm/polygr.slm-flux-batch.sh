#!/bin/bash
#FLUX: --job-name=polygrpfc
#FLUX: -N=4
#FLUX: --queue=MX
#FLUX: --urgency=16

export DISPLAY=''

source /etc/bashrc
module load polygrpfc/1.1
export DISPLAY=""
W=1000
H=1000
N=100
R=2
WW=`awk 'BEGIN{print int(1024/243*'$W')}'`
HH=`awk 'BEGIN{print int(1024/243*'$H')}'`
NN=$N
RR=$R
rm -rf *.in
cp $PFC_INP/step*.in ./
RX=`head /dev/urandom|cksum| awk '{print $1}'`
sed -i "s@xabc@$RX@g" step1.in
sed -i "s@WW@$WW@g" step1.in
sed -i "s@HH@$HH@g" step1.in
sed -i "s@NN@$NN@g" step1.in
sed -i "s@RR@$RR@g" step1.in
sed -i "s@WW@$WW@g" step2.in
sed -i "s@HH@$HH@g" step2.in
echo "Now run Step 1:"
mpirun polygrpfc step1
echo "Step 1 done."
echo ""
echo "Now run Step 2:"
mpirun polygrpfc step2
echo "Step 2 done."
echo ""
echo "Convert the images of Step 1 and 2:"
java -jar $PFC_JAR/coordinator.jar step2-t-10000.dat $WW $HH 0.7 0.7 7.3 2.46 \
          step2-t-10000.xy step2-t-10000.nh
java -jar $PFC_JAR/plotter.jar step1-t-# step1-t-# $WW $HH 0 1000 10000
java -jar $PFC_JAR/plotter.jar step2-t-# step2-t-# $WW $HH 0 1000 10000
echo "Images done."
echo ""
awk '{print $1+1,1,$2,$3,0}' step2-t-10000.xy > graphene.xyz
atomN=`tail -1 graphene.xyz |awk '{print $1}'`
sed -i "1i\ " graphene.xyz
sed -i "1i$atomN" graphene.xyz
rm -rf xyz2lmp.py
cat << EOF > xyz2lmp.py
from ovito.io import import_file
from ovito.io import export_file
node = import_file("graphene.xyz", columns = ["Particle Identifier", "Particle Type", "Position.X", "Position.Y", "Position.Z"])
export_file(node, "graphene.data", "lammps_data")
EOF
ovitos xyz2lmp.py
rm -rf xyz2lmp.py
sed -i "s@0.0 0.0 zlo zhi@-10.0 10.0 zlo zhi@g" graphene.data
mv graphene.data $SLURM_JOB_NAME.data
