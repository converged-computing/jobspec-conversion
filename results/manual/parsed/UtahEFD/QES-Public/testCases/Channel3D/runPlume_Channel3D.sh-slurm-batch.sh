#!/bin/bash
#FLUX: --job-name=QES-plume-Channel3D
#FLUX: --queue=efd-shared-np
#FLUX: -t=18000
#FLUX: --urgency=16

echo '****** PROLOGUE ******'
echo '----------------------------------------------------------------------------'
echo 'Hi, jobID: '$SLURM_JOBID
date
sacct -j $SLURM_JOBID
echo '----------------------------------------------------------------------------'
echo 'setting environment'
module load cuda/11.4
module load cmake/3.21.4
module load gcc/8.5.0
module load boost/1.77.0
module load intel-oneapi-mpi/2021.4.0
module load gdal/3.3.3
module load netcdf-c/4.8.1
module load netcdf-cxx/4.2
module load matlab
ulimit -c unlimited -s
module list
echo '****** START OF JOB ******'
cd MATLAB
matlab -nodisplay -nosplash -nodesktop -r "run('Channel3D_testcase.m');exit;"
cd ../../../build/
./qesPlume/qesPlume -q ../testCases/Channel3D/QES-files/Channel3D_1.83_18.3.xml -w ../testCases/Channel3D/QES-data/Channel3D_windsWk.nc -t ../testCases/Channel3D/QES-data/Channel3D_turbOut.nc -o ../testCases/Channel3D/QES-data/Channel3D_1.83_18.3 -l
./qesPlume/qesPlume -q ../testCases/Channel3D/QES-files/Channel3D_0.183_18.3.xml -w ../testCases/Channel3D/QES-data/Channel3D_windsWk.nc -t ../testCases/Channel3D/QES-data/Channel3D_turbOut.nc -o ../testCases/Channel3D/QES-data/Channel3D_0.183_18.3 -l
./qesPlume/qesPlume -q ../testCases/Channel3D/QES-files/Channel3D_0.00183_18.3.xml -w ../testCases/Channel3D/QES-data/Channel3D_windsWk.nc -t ../testCases/Channel3D/QES-data/Channel3D_turbOut.nc -o ../testCases/Channel3D/QES-data/Channel3D_0.00183_18.3  -l 
cd - 
matlab -nodisplay -nosplash -nodesktop -r "run('plotPlumeResults_Channel3D.m');exit;"
cd ..
echo '****** END OF JOB ****** '
echo '****** EPILOGUE ******'
echo '----------------------------------------------------------------------------'
sacct -j $SLURM_JOBID
sacct -j $SLURM_JOBID --format=Elapsed,NodeList
echo '----------------------------------------------------------------------------'
