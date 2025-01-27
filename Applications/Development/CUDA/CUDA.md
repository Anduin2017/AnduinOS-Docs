# CUDA

CUDA (Compute Unified Device Architecture) is a parallel computing platform and application programming interface (API) model created by NVIDIA. It allows software developers to use a CUDA-enabled graphics processing unit (GPU) for general-purpose processing.

## Before installing CUDA

Before installing CUDA, you need to make sure you have a compatible GPU. You can check the list of CUDA-enabled GPUs here: [https://developer.nvidia.com/cuda-gpus](https://developer.nvidia.com/cuda-gpus).

Try running `nvidia-smi` to see if you have a compatible GPU.

```bash
nvidia-smi
```

## Install CUDA

To install CUDA, download it here: [https://developer.nvidia.com/cuda-toolkit-archive](https://developer.nvidia.com/cuda-toolkit-archive).

Don't forget, you also need to decide which version of CUDA to install. **Not all CUDA supports all driviers!**

First you need know the verison of the driver via `nvidia-smi`. And query the doc to know which CUDA it supports:

[https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html)

Run:

```bash
echo "Installing CUDA... Do NOT select the driver!!!"
sudo sh ./cuda_11.8.0_520.61.05_linux.run

PATH="$PATH:/usr/local/cuda/bin"
echo "PATH=\"$PATH\"" | sudo tee /etc/environment > /dev/null

source /etc/environment

nvcc --version
```

That would install CUDA 11.8.0 on your system.

## Install Nvidia Container Toolkit

If you are using Docker, you may need to install Nvidia Container Toolkit.

Please refer to [document here](../Docker/Docker.md) to install Docker and Nvidia Container Toolkit if you need CUDA in Docker.

## Install cuDNN

To install cuDNN, download it here: [https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download).

Run:

```bash
echo "Installing CUDNN..."
sudo apt-get install ./cudnn-local-repo-ubuntu2204-8.9.0.131_1.0-1_amd64_cuda11.deb -y
sudo cp /var/cudnn-local-repo-*/cudnn-local-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get install libcudnn8=8.9.0.131-1+cuda11.8
sudo apt-get install libcudnn8-dev=8.9.0.131-1+cuda11.8
sudo apt-get install libfreeimage-dev
```

## Install PyTorch

**DO NOT** directly type `pip install torch`!!! The torch you installed may not be compatible with your CUDA and you may see error:

> AssertionError: Torch not compiled with CUDA enabled

First open here: [PyTorch](https://pytorch.org/get-started/locally/)

And finish this tutorial:

![tutorial-pytorch](https://anduin.aiursoft.cn/image/img-42995c63-588b-408b-9053-1c1df8ecabc8.png)

You may see a command:

```bash
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

That should be the correct command to run.

## How to tell if the driver is installed?

Run:

```bash
nvidia-smi
```

To get more details, like if it is licensed, run:

```bash
nvidia-smi -q
```

## How to tell if CUDA is installed?

Run:

```bash
/usr/local/cuda/bin/nvcc --version
```

To test the CUDA, create a `hello-world.cu`:

```c
#include <stdio.h>

__global__ void helloCUDA()
{
    printf("Hello CUDA from thread %d in block %d!\n", threadIdx.x, blockIdx.x);
}

int main()
{
    // 4 blocks, 8 threads per block
    int numBlocks = 4;
    int threadsPerBlock = 8;

    // launch kernel
    helloCUDA<<<numBlocks, threadsPerBlock>>>();

    // wait for device to finish
    cudaDeviceSynchronize();

    return 0;
}
```

Now run it!

```bash
nvcc ./hello-world.cu -o hello-world && ./hello-world
```

## How to tell if cuDNN is installed?

Run:

```bash
cat /usr/include/cudnn_version.h | grep CUDNN_M
```

To test it, run:

```bash
cp -r /usr/src/cudnn_samples_v8/ /tmp
cd  /tmp/cudnn_samples_v8/mnistCUDNN
make clean && make
./mnistCUDNN
```

If cuDNN is properly installed and running on your Linux system, you will see a message similar to the following:

>Test passed!

## How to tell if torch is installed?

Run `python`, and type:

```python
import  torch

print(torch.cuda.is_available())
```
