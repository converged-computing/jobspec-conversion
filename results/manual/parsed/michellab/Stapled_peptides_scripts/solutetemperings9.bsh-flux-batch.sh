#!/bin/bash
#FLUX: --job-name=SoluteTemp
#FLUX: -n=12
#FLUX: --queue=GTX
#FLUX: -t=172800
#FLUX: --priority=16

mkdir solutetemp
cd solutetemp
echo '' > plumed.dat
cp ../simprep/topol.top .
nrep=6
tmin=290
tmax=500
list=$(
awk -v n=$nrep \
    -v tmin=$tmin \
    -v tmax=$tmax \
  'BEGIN{for(i=0;i<n;i++){
    t=tmin*exp(i*log(tmax/tmin)/(n-1));
    printf(t); if(i<n-1)printf(",");
  }
}'
)
rm -fr \#*
for((i=0;i<nrep;i++))
do
  lambda=$(echo $list | awk 'BEGIN{FS=",";}{print $1/$'$((i+1))';}')
  plumed partial_tempering $lambda < topol.top > topol$i.top
done
cp /home/marie/Stapled_peptide_git/GROMACS_SIM/prod-300K-peptide.mdp prod.mdp
cp ../equilibration2/equilibration2-300/confout.gro   confout.gro  
echo '#! /bin/bash
for((i=0;i<nrep;i++))
do
  gmx grompp -p  topol$i.top -o topol$i.tpr -c  confout.gro -f  prod.mdp -maxwarn 1 
done
mpirun -n 6 ~/gromacs-2016.5/bui/bin/mdrun  -s topol.tpr -multi 6  -plumed plumed.dat -hrex -replex 50000
' > runsolute.bsh
scp -r ../solutetemp marie@section9.chem.ed.ac.uk:temp
