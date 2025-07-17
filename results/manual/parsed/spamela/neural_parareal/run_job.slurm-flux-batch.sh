#!/bin/bash
#FLUX: --job-name=frigid-rabbit-6675
#FLUX: --queue=skl_fua_prod
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_MODE='lib'
export OMP_STACKSIZE='512m'

module purge
module load profile/archive
module load gnuplot
module load intel/pe-xe-2018--binary intelmpi/2018--binary \
        mkl/2018--binary \
        zlib/1.2.8--gnu--6.1.0 \
        szip/2.1--gnu--6.1.0 \
        fftw \
        hdf5/1.8.18--intelmpi--2018--binary \
        lapack/3.8.0--intel--pe-xe-2018--binary \
        blas/3.8.0--intel--pe-xe-2018--binary
module load python/3.9.4 
source /marconi_work/FUA37_UKAEA_ML/spamela/Parareal/jorek_parareal/venv/bin/activate
export OMP_NUM_THREADS=1
export I_MPI_PIN_MODE=lib
export OMP_STACKSIZE=512m
python3 ./run_parareal_jorek.py -np 40 -coarse_not_slurm -no_ref -chkpt "initial_run" -ip 0 -ic 0 > output.txt
python3 ./run_parareal_jorek.py -np 4  -ninn 5 -nonn 10 -coarse_not_slurm -no_ref -chkpt "initial_run" -multi_chkpt -coarse_not_jorek -ip 0 -ic 0 > output.txt
