#!/bin/bash
#SBATCH --job-name=dask-workers-da8f4a54ae7156ba54a230dc16c53be4f3e56d93-2018-10-20
#SBATCH --output=logs/dask-workers-da8f4a54ae7156ba54a230dc16c53be4f3e56d93-2018-10-20.%J.out
#SBATCH --error=logs/dask-workers-da8f4a54ae7156ba54a230dc16c53be4f3e56d93-2018-10-20.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100
#SBATCH --time=1-00:00:00
#SBATCH --array=0-9

set -eo pipefail -o nounset
/sf/bernina/anaconda/ahl/bin/dask-worker --nthreads 1 --nprocs 1 --reconnect --nanny --bokeh  --local-directory "/photonics/home/lemke_h/mypy/escape-fel/slurmified_files" sf-cn-1.psi.ch:45509
