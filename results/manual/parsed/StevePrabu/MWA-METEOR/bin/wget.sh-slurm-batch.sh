#!/bin/bash
#SBATCH --mail-user=sirmcmissile47@gmail.com
#SBATCH --mail-type=FAIL,TIME_LIMIT
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=06:00:00

start=`date +%s`
module load singularity
shopt -s expand_aliases
source /astro/mwasci/sprabu/aliases
set -x
{
obsnum=OBSNUM
base=BASE
myPath=MYPATH
link=
while getopts 'l:' OPTION
do
    case "$OPTION" in
        l)
            link=${OPTARG}
            ;;
    esac
done
cd ${base}/processing/
mkdir ${obsnum}
cd ${obsnum}
mv ${obsnum}.ms old${obsnum}.ms
wget -O ${obsnum}_ms.tar "${link}"
tar -xvf ${obsnum}_ms.tar
end=`date +%s`
runtime=$((end-start))
echo "the job run time ${runtime}"
}
