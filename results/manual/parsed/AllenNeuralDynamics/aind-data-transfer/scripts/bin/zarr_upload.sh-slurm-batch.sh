#!/bin/bash
#SBATCH --output=/allen/programs/mindscope/workgroups/omfish/carsonb/hpc_outputs/%j_zarr_test.log
#SBATCH --mail-user=carson.berry@alleninstitute.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=1-06:00:00
#SBATCH --nodelist=n111
#SBATCH --exclude=n69,n74

set -e
pwd; date
[[ -f "/allen/programs/mindscope/workgroups/omfish/carsonb/miniconda/bin/activate" ]] && source "/allen/programs/mindscope/workgroups/omfish/carsonb/miniconda/bin/activate" adt-upload-clone
module purge
module load mpi/mpich-3.2-x86_64
mpiexec -np $(( SLURM_NTASKS + 2 )) python -m aind_data_transfer.jobs.zarr_upload_job --json-args '{"s3_bucket": "aind-open-data", "platform": "HCR", "modalities":[{"modality": "SPIM","source":"/allen/programs/mindscope/workgroups/omfish/mfish/temp_raw/diSPIM/HCR_662680-CON-R1-ID_2023-10-12_08-32-18", "extra_configs": "/allen/programs/mindscope/workgroups/omfish/mfish/temp_raw/zarr_config.yml"}], "subject_id": "662680", "acq_datetime": "2023-10-12 08:32:18", "force_cloud_sync": "true", "codeocean_domain": "https://codeocean.allenneuraldynamics.org", "metadata_service_domain": "http://aind-metadata-service", "aind_data_transfer_repo_location": "https://github.com/AllenNeuralDynamics/aind-data-transfer", "log_level": "INFO"}'
echo "Done"
date
