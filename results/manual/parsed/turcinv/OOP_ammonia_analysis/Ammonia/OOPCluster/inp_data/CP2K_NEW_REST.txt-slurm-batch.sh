#!/bin/bash
#SBATCH --job-name=ch102
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80Gb
#SBATCH --time=04:00:00
#SBATCH --partition=cpu,scpu,bfill
#SBATCH --qos=backfill
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=36

input=cluster_hybrid.inp
log=cluster_hybrid.log
source /opt/uochb/soft/spack/latest/share/spack/setup-env.sh #openmpi 3.1.6
spack env activate cp2k71
cp2k=cp2k.psmp
echo ' started at:' `date`
echo '   hostname:' `hostname`
echo " "
srun --mpi=pmix $cp2k $input >> $log
echo 'finished at:' `date`
dt="$(date '+%d/%m/%Y')"
finish="07/05/2022"
echo $dt
