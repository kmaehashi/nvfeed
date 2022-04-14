#!/bin/bash -uex

rm -rf _generate
cp -a _skeleton _generate

python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for Ubuntu 18.04 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/' \
    --file-suffix '.deb' \
    --output '_generate/cuda-ubuntu1804-x86_64.atom'
python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for Ubuntu 18.04 (x86_64) - Experimental' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/' \
    --file-suffix '.deb' \
    --output '_generate/TEST-cuda-ubuntu1804-x86_64-force-updated.atom' \
    --force-updated
python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for RHEL 8 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/' \
    --file-suffix '.rpm' \
    --output '_generate/cuda-rhel8-x86_64.atom'
python3 nvfeed.py \
    --name 'NVIDIA Machine Learning Packages for Ubuntu 18.04 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/' \
    --file-suffix '.deb' \
    --output '_generate/machine-learning-ubuntu1804-x86_64.atom'
