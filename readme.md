## Why does this exist

Because I got really tired of recompiling OpenCV dependencies in my own projects and cross compiling is miserable for GoCV. This solves **both** of those problems.

# Self contained OpenCV instance

This repository is a proper implementation of all dependencies needed for OpenCV to be portable and invokable by a x64 amd based docker image.

These dependencies are the bare-minimum needed to run OpenCV applications (or at-least in what I've tested out of box with ubuntu).

## Setup for Arm/Raspberry Pi

In order to leverage this you need a multi-architectured docker instance via qemu.

Thankfully I've already done the legwork and created a script that installs docker to your current system if it doesn't exist, and upgrades it to a multi-architectured environment.

## Using the default context and application in this directory

*The only real dependency is in https://github.com/actes2/go_image_streaming which you need to leverage to send*

You can utilize the run script I have in this directory to open up communications on port 4469.

From there, you just need to have a golang application invoke my 'send png' or 'send jpg' and point it at localhost:4469 or yourhosthere:4469

The default application is designed to spit out an output.png which you can plop down to the active directory using -v /app/ ./ or you can use the one-lined invoker script I made.

## Leveraging this as a boilerplate of sorts.

The only thing you need to actually do in this context is include a template.png (Or scrub that out of the Dockerfile yourself) and throw in your executable with the name *./opencv_app* that's really all there is to it.

You can then deploy this on any architecture and distro so long as it has _apt_ and _sudo_ along with an internet connection and the ability to properly run docker.
