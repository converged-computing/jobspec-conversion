#!/bin/bash
#FLUX: --job-name=psycho-cat-8802
#FLUX: --priority=16

export APP='ie2d'
export EXEC='./EXAMPLE/$APP'
export OMP_NUM_THREADS='$NTH'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module swap PrgEnv-intel PrgEnv-gnu
module unload darshan
module load hpctoolkit
module load hpcviewer
NTH=2
CORES_PER_NODE=32
THREADS_PER_RANK=`expr $NTH \* 2`								 
export APP=ie2d
export EXEC=./EXAMPLE/$APP
export OMP_NUM_THREADS=$NTH
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
for nmpi in  64 
do
NODE_VAL=`expr $nmpi / $CORES_PER_NODE \* $NTH`
for pat_comp in  3 #1: from right to left 2: from left to right 3: from outter to inner
do
for precon in 1  #1: direct 2: no preconditioner 3: LU preconditioner
do
model=7
Ns=( 100000) 
wavelengths=( 0.001)
for ((i = 0; i < ${#Ns[@]}; i++)); do
N=${Ns[i]}
wavelength=${wavelengths[i]}
blknum=1
tol=1d-4
tol_rand=1d-2
errcheck=0
lrcomp=5
bACAbatch=16
LRlevel=100
xyzsort=0
leafsize=200
para=0.01
schulzlevel=100		  
Nbundle=4 
format=1		  
verbosity=0
less_adapt=1
samplepara=20
knn=40
forwardN15flag=0
rm -rf hpctoolkit-$APP-measurements*
rm -rf hpctoolkit-$APP-database*
srun -n $nmpi -N $NODE_VAL -c $THREADS_PER_RANK --cpu_bind=cores hpcrun -e REALTIME -t $EXEC -quant --model2d $model --nunk $N --wavelength $wavelength -option --lr_blk_num $blknum --tol_comp $tol --tol_rand ${tol_rand}  --errfillfull $errcheck --reclr_leaf $lrcomp --verbosity $verbosity --forwardN15flag $forwardN15flag --sample_para $samplepara --less_adapt ${less_adapt} --baca_batch $bACAbatch --lrlevel $LRlevel --precon $precon --xyzsort $xyzsort --nmin_leaf $leafsize --near_para $para --pat_comp $pat_comp --schulzlevel $schulzlevel --nbundle $Nbundle --format $format --knn $knn | tee hcylindar_N_${N}_w_${wavelength}_tol_${tol}_mpi_${nmpi}_nth_${OMP_NUM_THREADS}_LRlevel_${LRlevel}_precon_${precon}_sort_${xyzsort}_pat_${pat_comp}_forwardN15flag_${forwardN15flag}_format_${format}
hpcstruct -j 16 $EXEC 
for entry in *; do
    entry1=$(echo $entry | grep hpctoolkit-$APP-measurements*)
    if [[ $entry1 != "" ]];then
    declare -a arr=($(echo $entry1 | grep -Eo '?[0-9]+([.][0-9]+)?'))
    num=${arr[${#arr[@]}-1]}
    fi
done
hpcprof -S $APP.hpcstruct hpctoolkit-$APP-measurements-$num
hpcviewer hpctoolkit-$APP-database-$num
done
done
done
done
