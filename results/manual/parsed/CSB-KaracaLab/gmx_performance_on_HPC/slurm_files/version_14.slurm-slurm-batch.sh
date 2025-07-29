#!/bin/bash
#SBATCH --job-name=64_threads
#SBATCH --account=bsavas
#SBATCH --output=DNMT3a-%j.out
#SBATCH --error=DNMT3a-%j.err
#SBATCH --mail-user=buusrasavas@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=akya-cuda

export OMP_NUM_THREADS='64'

source /etc/profile.d/modules.sh
module load centos7.3/app/gromacs/2020-impi-mkl-PS2018-GOLD-CUDA
module load  centos7.3/lib/cuda/10.0
module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5
module load centos7.3/lib/acml/6.1.0-gfortan64
export OMP_NUM_THREADS=64
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
$GROMACS_DIR/bin/gmx_mpi mdrun -v -deffnm complex_md -pin on
exit
