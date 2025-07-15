#!/bin/bash
#FLUX: --job-name=stinky-cupcake-7879
#FLUX: -N=2
#FLUX: -t=7200
#FLUX: --urgency=16

CONFIG=namd_production_script.conf
module load openmpi
module load namd/2.12-ibverbs-smp-cuda
NNODE=$SLURM_JOB_NUM_NODES
NTASKS=$SLURM_NTASKS_PER_NODE
GPUS=""
if [ "$CUDA_VISIBLE_DEVICES" != "" ]
then
  GPUS="+idlepoll +devices $CUDA_VISIBLE_DEVICES"
fi
echo $GPUS >> cuda.info
echo nvidia-smi >> cuda.info
scontrol show job $SLURM_JOBID >>scontrol.info
if [ -f ../prejob_processing.py ];
 then python3 ../prejob_processing.py $SLURM_JOBID -production;
 else echo "No pre-processing script." > pausejob
fi
if [ -f pausejob ]; then
    scancel $SLURM_JOBID;
    exit;
fi    
if [ $NNODE == 1 ]
 then
  # Single-node SMP
  namd2 ++ppn $NTASKS $GPUS "$CONFIG" >temp_working_outputfile.out 2>temp_working_errorsfile.err;
else
  # Multi-node SMP via MPI
  # PPN=`expr $SLURM_NTASKS_PER_NODE - 1 `   # <- usually one core reserved for comms. 
  PPN=`expr $SLURM_NTASKS_PER_NODE - 0 `
  P="$(($PPN * $SLURM_NNODES))"
  charmrun ++verbose ++mpiexec \
    ++remote-shell "`which mpirun` --map-by node" \
    `which namd2` ++p $P ++ppn $PPN +setcpuaffinity $GPUS \
    "$CONFIG" >temp_working_outputfile.out 2>temp_working_errorsfile.err;
fi
if [ -f ../postjob_processing.py ];
 then python3 ../postjob_processing.py $SLURM_JOBID -production;
 else echo "No post-processing script." > pausejob
fi
if [ -f pausejob ]; then
    scancel $SLURM_JOBID;
    exit;
fi    
sbatch sbatch_production_script
