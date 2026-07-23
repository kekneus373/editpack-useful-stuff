You *can* apply audio effects similar to Kdenlive's **Aexciter** in the terminal, but not directly using Kdenlive itself—Kdenlive is a GUI video editor and doesn’t expose its audio effects as terminal tools. However, Kdenlive uses **LADSPA**, **LV2**, or **FFmpeg** filters internally. The *Aexciter* effect is based on the **FFmpeg** plugin called `A-Exciter`.

---

### ✅ **AExciter comes from the `avfilter` set**

In **Kdenlive**, the `AExciter` effect is actually an **internal `avfilter.aexciter`** provided by MLT’s wrapper for **FFmpeg's `aexciter` filter**.

---

### 🔄 So how can you use `aexciter` from Kdenlive in terminal?

You can **use FFmpeg directly** with its built-in `aexciter` filter.

#### 🛠 Example:

```bash
ffmpeg -i <input> -af "aexciter=level_in=14.464:level_out=1.984:amount=1:drive=8.5:blend=0:freq=7500:ceil=9999" -vn <output> # -vn to remove video stream
```

This exactly matches your XML config:

| XML Param      | FFmpeg Param | Default     | Set    |
|----------------|--------------|-------------|--------|
| `av.level_in`  | `level_in`   | 1.000000    | 14.464 |
| `av.level_out` | `level_out`  | 1.000000    | 1.984  |
| `av.amount`    | `amount`     | 1.000000    | 1      |
| `av.drive`     | `drive`      | 8.500000    | 8.5    |
| `av.blend`     | `blend`      | 0.000000    | 0      |
| `av.freq`      | `freq`       | 7500.000000 | 7500   |
| `av.ceil`      | `ceil`       | 9999.000000 | 9999   |

---

### ✅ Requirements

Your **FFmpeg must be compiled with libavfilter support**, which NixOS does by default.

Check with:

```bash
ffmpeg -filters | grep aexciter
```

You should see:

```
 ... aexciter          AExciter audio enhancement filter
```
