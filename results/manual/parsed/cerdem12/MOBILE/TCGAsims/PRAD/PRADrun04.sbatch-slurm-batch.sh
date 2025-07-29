#!/bin/bash
#SBATCH --job-name=1203PRADSPINK1
#SBATCH --account=hpc2n2023-130
#SBATCH --output=matlab_%J.out
#SBATCH --error=matlab_%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

module add MATLAB/2023a.Update4
module add GCCcore/11.3.0
module add X11/20220504
module add binutils/2.38
matlab -nojvm -nodisplay -r "PRADSPINK1"
