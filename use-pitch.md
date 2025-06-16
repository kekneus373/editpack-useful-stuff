You can apply **pitch shifting** with FFmpeg just like `aexciter` — no GUI needed.

---

### ✅ **Using FFmpeg’s `asetrate` + `aresample` (classic trick)**

This is the most common **lightweight** method:

```bash
ffmpeg -i input.wav -af "asetrate=44100*0.8,aresample=44100" output.wav
```

* `0.8` lowers pitch \~4 semitones
* `>1` raises pitch, `<1` lowers it
* `aresample=44100` brings sample rate back to normal
* This method **preserves speed** after pitch shift

---

### ✅ **Alternative: `rubberband` (high-quality pitch shifter)**

Only works if FFmpeg is built with `librubberband` (NixOS has it if you add `ffmpeg-full`):

```bash
ffmpeg -i input.wav -af "rubberband=pitch=0.8" output.wav
```

This preserves formants better than `asetrate`. *And that is what I use!*

---

### 🤫 **Best pitch amount for "masking" a voice?**

For disguising a voice while keeping it natural-sounding:

| Pitch Factor | Result            | Notes                                     |
| ------------ | ----------------- | ----------------------------------------- |
| `0.95`       | Subtle shift down | Just enough to confuse voice match tools  |
| `0.85`       | Good disguise     | Makes the voice feel "heavier" or older   |
| `0.80`       | Deep & masked     | Still intelligible, but quite transformed |
| `0.70`       | Heavily masked    | Might start sounding unnatural            |

🎯 **Recommended for "masking": `0.80` or `0.85`**

> These give you a solid disguise without making it too obvious or robotic.

---

### 🧪 Combine pitch + exciter?

Absolutely. Example combo chain:

```bash
ffmpeg -i input.wav -af "aexciter=level_in=14.464:level_out=1.984:amount=1:drive=8.5:blend=0:freq=7500:ceil=9999,rubberband=pitch=0.80" output.wav
```

This makes the voice **richer** and **harder to recognize**. You can even add noise or reverb later if needed.

