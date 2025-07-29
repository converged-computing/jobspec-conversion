#!/bin/bash
#SBATCH --job-name=underlay_EE
#SBATCH --mail-user=bho.matthiesen@tu-dresden.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=7875
#SBATCH --time=1-23:59:59
#SBATCH --array=1-27

export UNDERLAY_HPC_SAVEDIR='/scratch/p_mimo/bho/underlay_OOBIF-2'
export UNDERLAY_WP_SUFFIX='_PIF1=-10dBW_d1=1000m_PIF2=-30dBW_d2=600m'

export UNDERLAY_HPC_SAVEDIR="/scratch/p_mimo/bho/underlay_OOBIF-2"
export UNDERLAY_WP_SUFFIX="_PIF1=-10dBW_d1=1000m_PIF2=-30dBW_d2=600m"
module load matlab
srun matlab -nodesktop -nodisplay -nosplash -r underlay_EE
