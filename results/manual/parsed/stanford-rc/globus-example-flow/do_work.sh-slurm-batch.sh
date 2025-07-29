#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=01:00:00

if [ $# -ne 2 ]; then
    echo 'ERROR!  The number of arguments should be only 2.'
    exit 1
fi
for arg in $1 $2; do
    if [ ! -d ${arg} ]; then
        echo 'ERROR!  ${arg} is not a directory.'
        exit 1
    fi
done
cd $1
exec find . -depth -not -type d -exec sha1sum --binary {} \; > $2/checksums
