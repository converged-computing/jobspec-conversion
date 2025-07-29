#!/bin/bash
#SBATCH --job-name=cxid9114_mask
#SBATCH --mail-user=loriordan@lbl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=regular

singularity
exec
docker:mlxd/xfel:lq79
if [ ! -f ./mask.sh ]; then
    echo "#\!/bin/bash" >> ./mask.sh
    echo "export SIT_DATA=/reg/g/psdm/data"  >> ./mask.sh
    echo "export SIT_PSDM_DATA=/reg/d/psdm"  >> ./mask.sh
    echo "source /build/setpaths.sh"  >> ./mask.sh
    echo "cxi.make_dials_mask --maxproj-min=50 -o mask.pickle \${1} \${2} \${3}" >> ./mask.sh
fi
srun -n 68 -c 1 --cpu_bind=cores shifter ./mask.sh ${1} ${2} ${3}
