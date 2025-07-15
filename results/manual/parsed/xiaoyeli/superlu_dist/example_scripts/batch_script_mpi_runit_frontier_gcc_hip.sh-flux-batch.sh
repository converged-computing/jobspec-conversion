#!/bin/bash
#FLUX: --job-name=wobbly-banana-3296
#FLUX: --priority=16

export MPICH_GPU_SUPPORT_ENABLED='1'
export LD_LIBRARY_PATH='$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH'
export CRAYPE_LINK_TYPE='dynamic'
export SUPERLU_NUM_GPU_STREAMS='1'
export SUPERLU_ACC_OFFLOAD='0'
export MAX_BUFFER_SIZE='500000000 '

EXIT_SUCCESS=0
EXIT_HOST=1
EXIT_PARAM=2
module load PrgEnv-gnu
module load gcc/11.2.0
module load cray-mpich/8.1.23                                   # version recommended in Jan 30 email
module load craype-accel-amd-gfx90a                                                # for GPU aware MPI
module load rocm/5.2.0                                             # version recommended in Jan 30 email
export MPICH_GPU_SUPPORT_ENABLED=1
module load cmake
export LD_LIBRARY_PATH="$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
export CRAYPE_LINK_TYPE=dynamic
CUR_DIR=`pwd`
FILE_DIR=$CUR_DIR/EXAMPLE
INPUT_DIR=$MEMBERWORK/csc289/matrix
FILE_NAME=pddrive
FILE=$FILE_DIR/$FILE_NAME
CORES_PER_NODE=64
export SUPERLU_NUM_GPU_STREAMS=1
export SUPERLU_ACC_OFFLOAD=0
export MAX_BUFFER_SIZE=500000000 
nprows=(4)
npcols=(4)
for ((i = 0; i < ${#npcols[@]}; i++)); do
NROW=${nprows[i]}
NCOL=${npcols[i]}
CORE_VAL=`expr $NCOL \* $NROW`
NODE_VAL=`expr $CORE_VAL / $CORES_PER_NODE`
MOD_VAL=`expr $CORE_VAL % $CORES_PER_NODE`
if [[ $MOD_VAL -ne 0 ]]
then
  NODE_VAL=`expr $NODE_VAL + 1`
fi
for NTH in 1 
do
OMP_NUM_THREADS=$NTH
  # for MAT in atmosmodl.rb nlpkkt80.mtx torso3.mtx Ga19As19H42.mtx A22.mtx cage13.rb 
  # for MAT in s1_mat_0_126936.bin 
  # for MAT in s1_mat_0_253872.bin s1_mat_0_126936.bin s1_mat_0_507744.bin
  # for MAT in Ga19As19H42.mtx Geo_1438.mtx
  # for MAT in DNA_715_64cell.bin Li4244.bin
  # for MAT in Geo_1438.mtx
  # for MAT in matrix121.dat
  #  for MAT in HTS/gas_sensor.mtx HTS/vanbody.mtx HTS/ct20stif.mtx HTS/torsion1.mtx HTS/dawson5.mtx
 # for MAT in HTS/gas_sensor.mtx 
  # for MAT in HTS/g7jac160.mtx
  # for MAT in HTS/gridgena.mtx
  # for MAT in HTS/hcircuit.mtx
  # for MAT in HTS/jan99jac120.mtx
  # for MAT in HTS/shipsec1.mtx
  # for MAT in HTS/copter2.mtx
  # for MAT in HTS/epb3.mtx
  # for MAT in HTS/twotone.mtx
  # for MAT in HTS/boyd1.mtx
  # for MAT in HTS/rajat16.mtx
  # for MAT in big.rua
  # for MAT in Geo_1438.mtx
  # for MAT in Ga19As19H42.mtx
  for MAT in s2D9pt2048.rua 
  # for MAT in matrix121.dat matrix211.dat tdr190k.dat tdr455k.dat nlpkkt80.mtx torso3.mtx helm2d03.mtx  
  # for MAT in tdr190k.dat Ga19As19H42.mtx
 # for MAT in torso3.mtx hvdc2.mtx matrix121.dat nlpkkt80.mtx helm2d03.mtx
  # for MAT in  A22.bin DNA_715_64cell.bin LU_C_BN_C_4by2.bin
 # for MAT in Ga19As19H42.mtx   
  do
    # Start of looping stuff
    export OMP_NUM_THREADS=$OMP_NUM_THREADS
    # export OMP_PLACES=threads
    # export OMP_PROC_BIND=spread
    mkdir -p $MAT
    #srun -n $CORE_VAL -c $NTH --cpu_bind=cores /opt/rocm/bin/rocprof --hsa-trace --hip-trace $FILE -c $NCOL -r $NROW $INPUT_DIR/$MAT | tee ./$MAT/SLU.o_mpi_${NROW}x${NCOL}_${OMP_NUM_THREADS}_mrhs
    #srun -n $CORE_VAL -c $NTH --cpu_bind=cores /opt/rocm/bin/rocprof --hsa-trace --roctx-trace $FILE -c $NCOL -r $NROW $INPUT_DIR/$MAT | tee ./$MAT/SLU.o_mpi_${NROW}x${NCOL}_${OMP_NUM_THREADS}_mrhs
    # srun -n $CORE_VAL -c $NTH --gpu-bind=closest --ntasks-per-gpu=1 --gpus $CORE_VAL --gpus-per-node=8 $FILE -c $NCOL -r $NROW $INPUT_DIR/$MAT | tee ./$MAT/SLU.o_mpi_${NROW}x${NCOL}_${OMP_NUM_THREADS}_mrhs
    srun -N ${SLURM_NNODES} --ntasks-per-node=8 --gpus-per-task=1 --gpu-bind=closest $FILE -c $NCOL -r $NROW $INPUT_DIR/$MAT | tee ./$MAT/SLU.o_mpi_${NROW}x${NCOL}_${OMP_NUM_THREADS}_mrhs
    # Add final line (srun line) to temporary slurm script
  done
done
done
exit $EXIT_SUCCESS
