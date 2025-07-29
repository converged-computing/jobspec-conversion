#!/bin/bash
#SBATCH --output=/mnt/nas2/redmine/bio_requests/12430/slurm_logs/job_%j.out
#SBATCH --error=/mnt/nas2/redmine/bio_requests/12430/slurm_logs/job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=55
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=191000
#SBATCH --time=1-00:00:00

docker run -u ubuntu -i -v /mnt/nas2:/mnt/nas2 --name cowbat --rm cowbat:latest /bin/bash -c "source activate cowbat && python3 assembly_pipeline.py -s /mnt/nas2/redmine/bio_requests/12430/fastqs -r /mnt/nas2/databases/assemblydatabases/0.3.4"
