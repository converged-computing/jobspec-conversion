#!/bin/bash
#FLUX: --job-name=lammps_test_job
#FLUX: -t=720000
#FLUX: --priority=16

module purge
conda --version
source /home/rs/anaconda3/etc/profile.d/conda.sh
conda activate mosdef-study38
module load impi
module load intel/2017.4.196
module load gcc
module load fftw
echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
echo $infile $seed $T $P $rcut $tstep
/home/rs/software/lammps-23Jun2022/lmp_mpi -in $infile -var seed $seed -var T $T -var P $P -var rcut $rcut -var tstep $tstep
