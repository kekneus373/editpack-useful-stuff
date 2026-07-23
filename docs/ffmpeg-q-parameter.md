According to the documentation, the `-q` parameter is used for variable bitrate encoding, and its value is not directly equivalent to a fixed bitrate. However, it's possible to estimate the bitrate based on the quality setting.

For video, the quality setting ranges from 2 (very poor) to 31 (lossless). According to the documentation [7], a quality setting of 23 corresponds to a bitrate of around 1-3 Mbps. However, this value can vary depending on the specific codec and other factors.

For audio, the quality setting ranges from 2 (very poor) to 128 (lossless). According to the documentation [8], a quality setting of 2 corresponds to a bitrate of around 128 kbps.

In summary, the `-q` parameter is not a direct measure of bitrate, but it can be used to estimate the quality of the encoded video or audio. For video, a quality setting of 23 corresponds to a bitrate of around 1-3 Mbps, while for audio, a quality setting of 2 corresponds to a bitrate of around 128 kbps.
