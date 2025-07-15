#!/bin/bash
#FLUX: --job-name=prod
#FLUX: -c=5
#FLUX: -t=86400
#FLUX: --urgency=16

source ~/.bashrc
source $scripts_dir/extract_execution_model_bash.sh
date
start=`date +%s`
rep=${repeats_array[SLURM_ARRAY_TASK_ID]}
no_lams=$3
eng=$2
trans=$1
echo "Folder for these runs is : $MAINDIRECTORY"
echo "The transformation is $trans using $no_lams windows and $eng as the MD engine for repeat $rep"
IFS=","
read -r -a lamvals <<< "${wins_array[$no_lams]}"
cd $MAINDIRECTORY/outputs/$eng/$trans
if [[ ! -d $MAINDIRECTORY/outputs/$eng/$trans ]]; then
    echo "$MAINDIRECTORY/outputs/$eng/$trans does not exist. Production run aborted..."
    exit
fi
trans_dir=$(pwd)
for dir in 'bound' 'free'; do
for lam in "${lamvals[@]}" ; do
repeat=${dir}_$rep
cd $MAINDIRECTORY/outputs/$eng/$trans/$repeat
repeat_dir=$(pwd)
echo "Running in $repeat_dir"
echo "Lambda is $lam"
if [ $eng = "SOMD" ]; then
module load cuda/11.2
module load gcc/9.1.0
nvidia-smi
source ~/anaconda3/etc/profile.d/conda.sh
conda activate sire
freenrg=somd-freenrg
echo "min + eq"
cd eq/lambda_$lam
$freenrg -c somd.rst7 -t somd.prm7 -m somd.pert -C somd.cfg -p CUDA
cd $repeat_dir
echo "copying restart files for production..."
cp eq/lambda_$lam/sim_restart.s3 lambda_$lam/sim_restart.s3
cp eq/lambda_$lam/sim_restart.s3.previous lambda_$lam/sim_restart.s3.previous
cp eq/lambda_$lam/SYSTEM.s3 lambda_$lam/SYSTEM.s3
echo "prod"
cd lambda_$lam
$freenrg -c somd.rst7 -t somd.prm7 -m somd.pert -C somd.cfg -p CUDA
cd $repeat_dir
fi
if [ $eng = "GROMACS" ]; then
module load gromacs/2023.1
echo "min"
gmx grompp -f min/lambda_$lam/gromacs.mdp -c min/lambda_$lam/gromacs.gro -p min/lambda_$lam/gromacs.top -o min/lambda_$lam/gromacs.tpr
gmx mdrun -deffnm min/lambda_$lam/gromacs ;
echo "heat"
gmx grompp -f heat/lambda_$lam/gromacs.mdp -c min/lambda_$lam/gromacs.gro -p heat/lambda_$lam/gromacs.top -o heat/lambda_$lam/gromacs.tpr
gmx mdrun -deffnm heat/lambda_$lam/gromacs ;
echo "eq"
gmx grompp -f eq/lambda_$lam/gromacs.mdp -c heat/lambda_$lam/gromacs.gro -p eq/lambda_$lam/gromacs.top -t heat/lambda_$lam/gromacs.cpt  -o eq/lambda_$lam/gromacs.tpr
gmx mdrun -deffnm eq/lambda_$lam/gromacs ;
echo "prod"
gmx grompp -f lambda_$lam/gromacs.mdp -c eq/lambda_$lam/gromacs.gro -p lambda_$lam/gromacs.top -t eq/lambda_$lam/gromacs.cpt -o lambda_$lam/gromacs.tpr
gmx mdrun -deffnm lambda_$lam/gromacs ;
fi
if [ $eng = "AMBER" ]; then
module load amber/20
echo "min"
    pmemd.cuda -i min/lambda_$lam/amber.cfg -c min/lambda_$lam/amber.rst7 -ref min/lambda_$lam/amber.rst7 -p min/lambda_$lam/amber.prm7 -O -o min/lambda_$lam/amber.out -inf min/lambda_$lam/amber.info -e min/lambda_$lam/amber.en -r min/lambda_$lam/amber.rst7 -x min/lambda_$lam/amber.nc -l min/lambda_$lam/amber.log ;
echo "heat"
    pmemd.cuda -i heat/lambda_$lam/amber.cfg -c min/lambda_$lam/amber.rst7 -ref min/lambda_$lam/amber.rst7 -p heat/lambda_$lam/amber.prm7 -O -o heat/lambda_$lam/amber.out -inf heat/lambda_$lam/amber.info -e heat/lambda_$lam/amber.en -r heat/lambda_$lam/amber.rst7 -x heat/lambda_$lam/amber.nc -l heat/lambda_$lam/amber.log ;
echo "eq"
    pmemd.cuda -i eq/lambda_$lam/amber.cfg -c heat/lambda_$lam/amber.rst7 -ref heat/lambda_$lam/amber.rst7 -p eq/lambda_$lam/amber.prm7 -O -o eq/lambda_$lam/amber.out -inf eq/lambda_$lam/amber.info -e eq/lambda_$lam/amber.en -r eq/lambda_$lam/amber.rst7 -x eq/lambda_$lam/amber.nc -l eq/lambda_$lam/amber.log ;
echo "prod"
    pmemd.cuda -i lambda_$lam/amber.cfg -c eq/lambda_$lam/amber.rst7 -ref eq/lambda_$lam/amber.rst7 -p lambda_$lam/amber.prm7 -O -o lambda_$lam/amber.out -inf lambda_$lam/amber.info -e lambda_$lam/amber.en -r lambda_$lam/amber.rst7 -x lambda_$lam/amber.nc -l lambda_$lam/amber.log ;
fi
done
done
echo "done."
end=`date +%s`
runtime=$((end-start))
echo "runtime was $runtime seconds, which is $((runtime/60)) minutes"
if [ "$eng" = "AMBER" ] || [ "$eng" = "ALL" ] && [ "$keep_traj" = "None" ]; then
for i in $(find $trans_dir -name 'amber.nc');
do
    rm -rf $i
done
fi
if [ "$eng" = "GROMACS" ] || [ "$eng" = "ALL" ] && [ "$keep_traj" = "None" ]; then
for i in $(find $trans_dir -name 'gromacs.trr');
do
    rm -rf $i
done
fi
if [ "$eng" = "SOMD" ] || [ "$eng" = "ALL" ] && [ "$keep_traj" = "None" ]; then
for i in $(find $trans_dir -name 'traj*.dcd');
do
    rm -rf $i
done
for i in $(find $trans_dir -name '*.s3*');
do
    rm -rf $i
done
fi
if [ "$eng" = "AMBER" ] || [ "$eng" = "ALL" ] && [ "$keep_traj" = "0,1" ]; then
for i in $(find $trans_dir -name 'amber.nc');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
if [ "$eng" = "GROMACS" ] || [ "$eng" = "ALL" ]&& [ "$keep_traj" = "0,1" ]; then
for i in $(find $trans_dir -name 'gromacs.trr');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
if [ "$eng" = "SOMD" ] || [ "$eng" = "ALL" ]&& [ "$keep_traj" = "0,1" ]; then
for i in $(find $trans_dir -name 'traj*.dcd');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
for i in $(find $trans_dir -name '*.s3*');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
if [ "$eng" = "AMBER" ] || [ "$eng" = "ALL" ] && [ "$keep_traj" = "0,0.5,1" ]; then
for i in $(find $trans_dir -name 'amber.nc');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_0.5000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
if [ "$eng" = "GROMACS" ] || [ "$eng" = "ALL" ]&& [ "$keep_traj" = "0,0.5,1" ]; then
for i in $(find $trans_dir -name 'gromacs.trr');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_0.5000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
if [ "$eng" = "SOMD" ] || [ "$eng" = "ALL" ]&& [ "$keep_traj" = "0,0.5,1" ]; then
for i in $(find $trans_dir -name 'traj*.dcd');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_0.5000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
for i in $(find $trans_dir -name '*.s3*');
do
if [[ "$i" != *"lambda_0.0000"* ]] && [[ "$i" != *"lambda_0.5000"* ]] && [[ "$i" != *"lambda_1.0000"* ]]; then
    rm -rf $i
fi
done
fi
echo "Done deleting, keeping $keep_traj trajectories."
