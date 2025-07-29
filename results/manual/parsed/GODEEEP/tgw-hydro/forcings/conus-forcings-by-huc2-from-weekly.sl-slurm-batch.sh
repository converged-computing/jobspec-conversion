#!/bin/bash
#SBATCH --account=GODEEEP
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=2-00:00:00

echo 'Loading modules'
module load python/miniconda3.9
source /share/apps/python/miniconda3.9/etc/profile.d/conda.sh
conda activate vic
echo 'Done loading modules'
nworker=1 # the dask threads will be split into the dask workers to share memory
start_year=1979
end_year=2022
for ((year = start_year; year <= end_year; year++))
do
    echo Started for Year $year
    python -u conus-forcings-by-huc2-from-weekly.py $year $nworker
    echo Completed for Year $year
done
echo 'Really Done'
