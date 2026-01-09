Video stabilization using VidStab and FFMPEG
--------------------------------------------

** Step 1 **

Install ffmpeg with the vidstab plugin.

- OSX: Install via [Homebrew](https://brew.sh/) - `brew install ffmpeg --with-libvidstab`
- Linux: [download binaries here](https://johnvansickle.com/ffmpeg/) (vidstab included)
- Windows: [download binaries here](https://www.gyan.dev/ffmpeg/builds/) (vidstab included)

** Step 2 **

Analyze any video and generate a so called transform file, which describes camera movements. The command below generates a `transforms.trf` file

```
ffmpeg -i input.mp4 -vf vidstabdetect=shakiness=7 -f null -
```

Options:
- **shakiness**: Set the shakiness of input video or quickness of camera. It accepts an integer in the range 1-10, a value of 1 means little shakiness, a value of 10 means strong shakiness. Default value is 5.

** Step 3 **

Stabilize video

```
ffmpeg -i input.mp4 -vf vidstabtransform=smoothing=30:zoom=5:input="transforms.trf" stabilized.mp4
```

Options:
- **smoothing**: Default value is 10. For example, a number of 10 means that 21 frames are used (10 in the past and 10 in the future) to smoothen the motion in the video. A larger value leads to a smoother video, but limits the acceleration of the camera (pan/tilt movements).
  - recommended value: `videoFPS / 2`
- **zoom**: Set percentage (%) to zoom into video. A positive value will result in a zoom-in effect, a negative value in a zoom-out effect. Default value is 0 (no zoom).

Read more in the [vidstab documentation](https://github.com/georgmartius/vid.stab)

