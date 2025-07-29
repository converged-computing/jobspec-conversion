#!/bin/bash
#SBATCH --job-name=ACES_hnco_analysis
#SBATCH --account=astronomy-dept
#SBATCH --output=/blue/adamginsburg/adamginsburg/ACES/logs/ACES_hnco_analysis_%j.log
#SBATCH --mail-user=adamginsburg@ufl.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=256gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=astronomy-dept-b

export USE_DASK='True'

date
. ~/.gh_token
echo $GITHUB_TOKEN
cd /blue/adamginsburg/adamginsburg/ACES/workdir/
pwd
export USE_DASK=True
if [ -e /orange/adamginsburg/ACES/mosaics/cubes/HNCO_CubeMosaic.fits ]; then
    echo "test import"
    /orange/adamginsburg/miniconda3/envs/python39/bin/python -c "import zipfile" || exit 1
    export MOLNAME='hnco'
    echo "Giant HNCO cube"
    /orange/adamginsburg/miniconda3/envs/python39/bin/python /orange/adamginsburg/ACES/reduction_ACES/aces/analysis/giantcube_cuts.py || exit 1
else
    echo "hnco_CubeMosaic.fits does not exist"
    ls -lh SiO*fits
fi
