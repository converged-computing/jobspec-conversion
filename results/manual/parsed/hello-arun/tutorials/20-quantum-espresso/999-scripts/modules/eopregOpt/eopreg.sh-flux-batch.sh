#!/bin/bash
#FLUX: --job-name=hello-ricecake-7281
#FLUX: --queue=batch
#FLUX: -t=900
#FLUX: --urgency=16

quantity="eopreg"           #the variable in the scf file to change valeus you can name it random  to calculate without any change
values="0.10 0.20 0.30 0.40"      # when you want to calculate without any change just put any single value here
np=`awk '/^np/ {print $3}' base.sh` 
cd ../
mkdir -p ./postProcessing
for value in $values
do
echo $quantity\_$value >> ./postProcessing/$quantity\_list.sh
mkdir -p $quantity\_$value
awk -v value="$value" -v quantity="$quantity" '$0 ~ quantity {$3 = value} /emaxpos/ { $3 = 1.0-value/2}{print}' ./scf.in > ./$quantity\_$value/scf.in
cat > ./$quantity\_$value/pp.in <<EOF
&INPUTPP
outdir='./out',
plot_num = 11
filplot = "pot.out"
/
EOF
cat > ./$quantity\_$value/avg.in <<EOF
1
pot.out
1.D0
150
3
1.000000
EOF
cat > ./$quantity\_$value/runAvgPot.sh << EOF
module load quantumespresso/6.6
mpirun -np \$(nproc) pw.x <scf.in> scf.out
pp.x <pp.in>   pp.out
average.x <avg.in> avg.out
(awk '/Fermi energy/{ print "#"\$0 }' scf.out  && cat avg.dat ) > temp
mv temp avg.dat
cp avg.dat ../postProcessing/avg.$quantity\_$value.sh
awk '/^!/ {print $value, \$5}' scf.out >> ../etot_vs_${quantity}
EOF
cd ./$quantity\_$value
(echo "$quantity = $value ##" &&  sbatch runAvgPot.sh) >> ../ZScripts/jobs.sh 
cd ..
done
