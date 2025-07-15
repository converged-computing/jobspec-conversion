#!/bin/bash
#FLUX: --job-name=stingray
#FLUX: -n=3
#FLUX: -t=172800
#FLUX: --priority=16

module load gfortran/6.3.0 hdf5/1.10.2
srun -n 1 /home/dobreschkow/stingray/stingray -parameterset dsa-wide-hyades -parameterfile /home/dobreschkow/stingray/parameters.txt -logfile /home/dobreschkow/log_dsa_wide.txt &
srun -n 1 /home/dobreschkow/stingray/stingray -parameterset dsa-pulsar-hyades -parameterfile /home/dobreschkow/stingray/parameters.txt -logfile /home/dobreschkow/log_dsa_pulsar.txt &
srun -n 1 /home/dobreschkow/stingray/stingray -parameterset dsa-deep-hyades -parameterfile /home/dobreschkow/stingray/parameters.txt -logfile /home/dobreschkow/log_dsa_deep.txt
wait
