#!/bin/bash
#FLUX: --job-name=chocolate-plant-1536
#FLUX: --exclusive
#FLUX: --queue=g100_usr_prod
#FLUX: -t=1200
#FLUX: --urgency=16

module load spack 
spack load adios2@2.9.1
mkdir -p results/sb_prod_cons_$SLURM_NNODES
OUTDIR="results/sb_prod_cons_$SLURM_NNODES"
if [ $# -ne 2 ]; then
	echo "input error: file size (in bytes) and number of files required"
	exit 1
fi
echo Number of nodes $SLURM_NNODES
read -d ' ' -a list <<< "$(scontrol show hostnames $SLURM_NODELIST)"
file_size=$1
n_files=$2
echo "executing writer in node ${list[0]}"
srun -n 1 -w ${list[0]} ./writer $file_size $n_files 0 >>$OUTDIR/writer_time_spsc.txt 2> $OUTDIR/writer_spsc.log
echo writer terminated
if [ $SLURM_NNODES -eq 1 ]; then
	reader_node=${list[0]}
	echo "reader in local node $reader_node"
else
	reader_node=${list[1]}
	echo "reader in remote node $reader_node"
fi
srun -n 1 -w $reader_node  ./reader $n_files 0 $file_size >> $OUTDIR/reader_time_spsc.txt 2> $OUTDIR/reader_spsc.log
echo reader terminated
rm -rf *.sb
