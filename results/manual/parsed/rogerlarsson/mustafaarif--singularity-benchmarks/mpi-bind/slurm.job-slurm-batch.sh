#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --account=pdc.staff
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=128

export LD_LIBRARY_PATH='/opt/cray/pe/lib64:/usr/lib64:$LD_LIBRARY_PATH'
export SINGULARITYENV_LD_LIBRARY_PATH='$LD_LIBRARY_PATH'

export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/cray/pe/lib64:/usr/lib64:$LD_LIBRARY_PATH
export SINGULARITYENV_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
echo $SINGULARITYENV_LD_LIBRARY_PATH
srun --ntasks=1 singularity exec -B /etc/libibverbs.d:/etc/libibverbs.d:ro -B /var/spool:/var/spool -B /usr/lib64:/usr/lib64:ro -B /opt:/opt:ro -B /var/opt:/var/opt:ro ./mpi-bw-bind.sif bash -c 'ldd /mpiapp/mpi_bandwidth'
srun --ntasks=256 singularity exec -B /etc/libibverbs.d:/etc/libibverbs.d:ro -B /var/spool:/var/spool -B /usr/lib64:/usr/lib64:ro -B /opt:/opt:ro -B /var/opt:/var/opt:ro ./mpi-bw-bind.sif bash -c '/mpiapp/mpi_bandwidth'
