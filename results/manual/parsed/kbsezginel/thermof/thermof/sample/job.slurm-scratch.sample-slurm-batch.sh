#!/bin/bash
#FLUX: --job-name=therMOF
#FLUX: -N=2
#FLUX: -t=43200
#FLUX: --urgency=16

export I_MPI_FABRICS_LIST='ofa'

module load intel/2017.1.132 intel-mpi/2017.1.132
shopt -s nullglob # Sets nullglob
inputs=$(ls {data,in,job,simpar}.*)
shopt -u nullglob # unsets nullglob
for i in ${inputs[@]}; do
    sbcast $SLURM_SUBMIT_DIR/$i $SLURM_SCRATCH/$i
done
ulimit -s unlimited
zfs=/zfs1/7/cwilmer/kbs37/Lammps
mofdir=`dirname "$SLURM_SUBMIT_DIR"`
mofdir=${mofdir##*/}
rundir=`basename "$SLURM_SUBMIT_DIR"`
outdir=$zfs/$mofdir/$rundir
mkdir -p $outdir
run_on_exit(){
  cp -pR $SLURM_SCRATCH/* $outdir/.
}
trap run_on_exit EXIT
cd $SLURM_SCRATCH
export I_MPI_FABRICS_LIST="ofa"
lmpdir=/ihome/cwilmer/pab135/workspace/lammps-hf-h2p/src/lmp_mpi
srun --mpi=pmi2 $lmpdir -in in.therMOF > lammps_out.txt
