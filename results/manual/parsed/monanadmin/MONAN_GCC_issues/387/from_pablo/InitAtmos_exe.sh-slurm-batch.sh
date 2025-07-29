#!/bin/bash
#SBATCH --job-name=ic_mpas
#SBATCH --output=/mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/my_job_ic.o%j
#SBATCH --error=/mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs/my_job_ic.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='1'
export PMIX_MCA_gds='hash'

export OMP_NUM_THREADS=1
ulimit -c unlimited
ulimit -v unlimited
ulimit -s unlimited
export PMIX_MCA_gds=hash
. /home/julio.fernandez/.spack/gnu/env.sh
spack load --only dependencies mpas-model%gcc@9.4.0
spack load --list
cd /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100
echo  "STARTING AT `date` "
Start=`date +%s.%N`
echo $Start >  /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing.InitAtmos
mpirun -np $SLURM_NTASKS ./init_atmosphere_model
End=`date +%s.%N`
echo  "FINISHED AT `date` "
echo $End   >> /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing.InitAtmos
echo $Start $End | awk '{print $2 - $1" sec"}' >>  /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/Timing.InitAtmos
 mv Timing.InitAtmos log.*.out /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/logs
 mv namelist.init* streams.init* /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
 mv InitAtmos_exe.sh /mnt/beegfs/julio.fernandez/MPAS/testcase/runs/GFS2/2021060100/scripts
date
exit 0
