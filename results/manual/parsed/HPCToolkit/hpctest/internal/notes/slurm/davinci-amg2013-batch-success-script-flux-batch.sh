#!/bin/bash
#FLUX: --job-name=AMG2013
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=commons
#FLUX: -t=1800
#FLUX: --priority=16

/usr/bin/time  -f '%e %S %U' -o gort-normal-time.txt srun -v /bin/bash -c "module load GCC/4.8.5 OpenMPI/1.8.6 Python/2.7.9 cURL/7.40.0 CMake/2.8.12.2; ulimit -c 204800 -u 500 -d 2097152 -f 2097152 -s 102400 -t unlimited ; cd /home/skw0897/hpctest/internal/spack/opt/spack/linux-rhel6-x86_64/gcc-4.8.5/AMG2013-1.0-nwtaeb4jworppff4d2qlk6atftsv2t3p/bin/;  ./amg2013 -P 1 2 2  -r 24 24 24" 
