#!/bin/bash
#FLUX: --job-name=rainbow-salad-1205
#FLUX: -N=2
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=large
#FLUX: --urgency=16

sleep 20
outdir=$1
tr_size=$2
working_directory=$PWD
cd $working_directory/bin
module load gcc openmpi
srun --ntasks-per-node=1 -n $SLURM_NNODES sync 
sleep 20
srun --ntasks-per-node=1 -n $SLURM_NNODES sync 
sleep 20
echo "srun ior -t${tr_size}k -b4g -w  -C -F   -o $working_directory/$outdir/log/$SLURM_NTASKS.bin > $working_directory/$outdir/$SLURM_NTASKS.txt"
srun ior -t${tr_size}k -b4g -w  -C -F  -o $working_directory/$outdir/log/$SLURM_NTASKS.bin > $working_directory/$outdir/$SLURM_NTASKS.txt 
