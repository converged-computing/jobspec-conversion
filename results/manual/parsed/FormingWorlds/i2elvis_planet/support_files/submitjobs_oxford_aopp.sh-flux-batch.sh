#!/bin/bash
#FLUX: --job-name=anxious-citrus-0950
#FLUX: --urgency=16

prefix=${PWD##*/}
echo "#!/bin/sh" >> submit.sh
echo "#SBATCH --job-name=$prefix" >> submit.sh
echo "#SBATCH --output=$prefix.out" >> submit.sh
echo "#SBATCH --error=$prefix.err" >> submit.sh
echo "#SBATCH --time=336:00:00" >> submit.sh
echo "#SBATCH --ntasks=1" >> submit.sh
echo "#SBATCH --mem=3000" >> submit.sh
echo "#SBATCH -p priority-rp" >> submit.sh # Pierrehumbert priority queue
echo "#SBATCH --cpus-per-task=1" >> submit.sh
echo "date" >> submit.sh
echo "export OMP_NUM_THREADS=1" >> submit.sh
echo "otheros/generic-arc" >> submit.sh
echo "module load intel-compilers/2015" >> submit.sh
echo "module load intel-mpi/2015" >> submit.sh
echo "module load intel-mkl/2015" >> submit.sh
echo "./in2mart" >> submit.sh
echo "./i2mart" >> submit.sh
echo "date" >> submit.sh
sbatch ./submit.sh
rm -r submit.sh
