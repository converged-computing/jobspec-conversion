#!/bin/bash
#SBATCH --job-name=an2month
#SBATCH --account=IHESD
#SBATCH --output=an2month-%A.%a.out
#SBATCH --error=an2month-%A.%a.err
#SBATCH --mail-user=chris.vernon@pnnl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=short

module purge
module load gcc/8.1.0
module load gdal/2.3.1
module load python/3.7.2
module load R/3.4.3
source /people/d3y010/virtualenvs/py3.7.2_an2month/bin/activate
START=`date +%s`
python /people/d3y010/an2month/code/python_l3.py $SLURM_ARRAY_TASK_ID
END=`date +%s`
RUNTIME=$(($END-$START))
echo $RUNTIME
