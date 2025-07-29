#!/bin/bash
#SBATCH --job-name=mymat
#SBATCH --output=mymat.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:35:00
#SBATCH --partition=development

export INTEL_LICENSE_FILE='/home1/02687/binren/intel/licenses/intel.current.20170224.lic'
export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

module load vtune
export INTEL_LICENSE_FILE=/home1/02687/binren/intel/licenses/intel.current.20170224.lic
export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
amplxe-cl -collect knc-bandwidth -r "../vtune10" -target-duration-type=long ./main ../../input/32-3.0r/32-3.0r.mesh.matlab ../../input/32-3.0r/32-3.0r.xyz
