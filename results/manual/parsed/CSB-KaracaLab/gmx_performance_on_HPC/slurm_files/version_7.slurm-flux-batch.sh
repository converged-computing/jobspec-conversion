#!/bin/bash
#FLUX: --job-name=akya_2020_pds_1gpu
#FLUX: -n=40
#FLUX: --queue=akya-cuda
#FLUX: -t=1296000
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'

source /etc/profile.d/modules.sh
module load centos7.3/app/gromacs/2020-impi-mkl-PS2018-GOLD-CUDA
module load  centos7.3/lib/cuda/10.0
module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5
module load centos7.3/lib/acml/6.1.0-gfortan64
export OMP_NUM_THREADS=20
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
$GROMACS_DIR/bin/gmx_mpi grompp -v -f 06_md_PME.mdp -c complex-NPT-noPR.gro -p complex.top -n index.ndx -o complex_md.tpr  -r complex-NPT-noPR.tpr
$GROMACS_DIR/bin/gmx_mpi mdrun -v -deffnm complex_md -pin on
exit
