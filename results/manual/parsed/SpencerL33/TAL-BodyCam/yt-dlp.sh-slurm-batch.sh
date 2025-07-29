#!/bin/bash
#SBATCH --job-name=yt-dlp
#SBATCH --account=def-panos
#SBATCH --output=out/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=512M
#SBATCH --time=03:00:00

module load python/3.10
module list
source ENV/bin/activate
cd pages
yt-dlp --config-locations /project/6003167/slee67/bodycam/yt-dlp.conf https://vimeo.com/user51379210/videos
