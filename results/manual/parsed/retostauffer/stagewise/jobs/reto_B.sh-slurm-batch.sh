#!/bin/bash
#SBATCH --job-name=retoB
#SBATCH --output=slurm-%x-%j_%a.out
#SBATCH --error=slurm-%x-%j_%a.err
#SBATCH --mail-user=Reto.Stauffer@uibk.ac.at
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=05:00:00

export SINGULARITY_BIND='/home/c403/c4031021/stagewise:/stagewise'

SIF="ssdr.sif"
if [ ! -f ${SIF} ] ; then
	printf "Cannot find singularity container \"%s\"" "${SIF}"
	exit 667
fi
module load singularityce/3.10.3-python-3.10.8-gcc-8.5.0-fzp3had
export SINGULARITY_BIND="/home/c403/c4031021/stagewise:/stagewise"
singularity exec ${SIF} /bin/bash <<-EOF
cd /stagewise && \
Rscript reto_test.R -m 100 -n 1000000 -p 1000 --ff
EOF
