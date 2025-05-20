# Flux batch script

# Resources
--nodes=1
--time=48:30:00
--partition=gpu_titanrtx

# Software (using shell commands to mimic module loading)
source /path/to/2019/setup.sh  # Replace with actual setup script path
source /path/to/TensorFlow/setup.sh # Replace with actual setup script path

echo "Running on Lisa System"

# Execute the application
python3 $HOME/main.py