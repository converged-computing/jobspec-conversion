#!/bin/bash
#FLUX: --job-name=creamy-cattywampus-1338
#FLUX: --priority=16

prefix=${PWD##*/}
echo "#!/bin/sh" >> submit.sh
echo "#SBATCH --job-name=$prefix" >> submit.sh
echo "#SBATCH --output=$prefix.out" >> submit.sh
echo "#SBATCH --error=$prefix.err" >> submit.sh
echo "#SBATCH --time=336:00:00" >> submit.sh
echo "#SBATCH --ntasks=1" >> submit.sh
echo "#SBATCH --mem=3000" >> submit.sh
echo "#SBATCH -p priority-rp" >> submit.sh
echo "#SBATCH --cpus-per-task=1" >> submit.sh
echo "date" >> submit.sh
echo "module load netcdf/4.4.1__intel2015" >> submit.sh
echo "module load intel-compilers/2015" >> submit.sh
echo "module load intel-mpi/2015" >> submit.sh
echo "module load intel-mkl/2015" >> submit.sh
echo "./i2mart" >> submit.sh
echo "date" >> submit.sh
sbatch ./submit.sh
rm -r submit.sh
