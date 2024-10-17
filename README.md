# CogVideo in docker
## Synopsis
In this repo I created Dockerfile and docker-compose config and gave a few examples 
on how to run [CogVideo](https://github.com/THUDM/CogVideo/tree/main?tab=readme-ov-file#cogvideo--cogvideox) models in a local laptop with low memory 
and low performance video cards. 
This config was tested with Dell G15 5535 with  RTX 4060 8Gb VRAM. 

## Prerequisites
* I test it on Ubuntu 24.04.1 LTS with docker ce 27.2.1. In theory it should work with any docker and ubuntu version that compatibles with nvidia container toolkit. 
* Nvidia container toolkit should be installed. You can find instruction here: 	 	 	 	
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
* You should have enough disk space. I use as a base image nvidia/cuda:12.6.1-cudnn-devel-ubuntu24.04  image that by itself has size 8Gb+ and CogVideo models have huge size too. THUDM/CogVideoX-5b (all parts) has size ~20Gb if you want to try other models like I2V or 2B version they also have near ~20Gb per model
* You should have good interent connection because on the first launch 5B model will be download and it may take some time

## Installation
* Clone CogVideo repo ```git clone https://github.com/THUDM/CogVideo.git```
* Clone this repo ```git clone  https://github.com/vitalek84/CogVideoInDocker.git```
* Copy files from this project to CogVideo repo:
  * ```cp CogVideoInDocker/docker-compose.yaml CogVideo/```
  * ```cp CogVideoInDocker/Dockerfile CogVideo/```
  * ```cp CogVideoInDocker/cogv_exploration.ipynb CogVideo/```
  *  ```cp CogVideoInDocker/*.mp4 CogVideo/```
* ```cd CogVideo```
* ```touch .env```  we don't use it for now but it created for future releases
* ```docker compose up```
* Copy jupyter link from cli and paste to a browser 
* Open notebook cogv_exploration.ipynb

## Usage
By default docker compose runs jupyter notebook and you can reply all commands from jupyter notebook. 
I deliberately did not rewrite the code for launching from a notebook directly, 
I launch everything via !python3 for the purpose of saving backward compatibility 
with native CogVideo demo. You can find all my experiments and prompts inside the notebook. 
Every example maybe launched from cli via docker compose like example
```docker compose run python3 inference/cli_demo.py --prompt "cool boy"```

# Notes

* I couldn’t receive any results from image to video model. It always returned None object. I opened an issue in the CogVideo repo.
* 2B version of the model also didn’t launch because it consumed too much memory on loading. So 32Gb memory were not enough for it. Maybe it is a bug that will be fixed later.
* You may find venv configuration inside Dockerfile and it looks odd but in new ubuntu it is an issue to rewrite system python’s packages so I use venv for easier installation.  
* torchao==0.4.0 in Dockerfile is important if you want to launch a quantization demo. Because it seems the latest torchao has some breaking changes that haven't yet reflected in CogVideo.
* During my test I noticed that CogVideo didn’t consume more than 3.5 Gb VRAM. So In theory CogVideo is able to launch on video cards with 4Gb VRAM. But I didn’t test it.
* There are a few notebooks for Colab. I tried launching them and I have very unstable results inside Colab (it crashed every second retry). Also I tried to launch notebooks on my laptop with camenduru/cogvideox-5b-float16 model and they crashed by VRAM issues. I didn't analyse issues deeply, maybe it is just temporary issues (will fix soon in new CogVideo releases) and you should try them on your laptop. Here are links:
  * https://colab.research.google.com/drive/1pCe5s0bC_xuXbBlpvIH1z0kfdTLQPzCS?usp=sharing#scrollTo=ONXqiegkzw6I Text2Video
  * https://colab.research.google.com/drive/17CqYCqSwz39nZAX2YyonDxosVKUZGzcX?usp=sharing#scrollTo=VPKgiLhF3K-J Image2Video
  * https://colab.research.google.com/drive/1DUffhcjrU-uz7_cpuJO3E_D4BaJT7OPa?usp=sharing#scrollTo=IzomEvqe2bA- Text2Video with Quantization

