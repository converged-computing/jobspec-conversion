#!/bin/bash
#FLUX: --job-name=red-omelette-6809
#FLUX: -n=55
#FLUX: -t=86400
#FLUX: --priority=16

docker run -u ubuntu -i -v /mnt/nas2:/mnt/nas2 --name cowbat --rm cowbat:latest /bin/bash -c "source activate cowbat && python3 assembly_pipeline.py -s /mnt/nas2/redmine/bio_requests/12430/fastqs -r /mnt/nas2/databases/assemblydatabases/0.3.4"
