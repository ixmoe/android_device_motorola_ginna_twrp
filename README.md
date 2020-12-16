# TWRP Device configuration for Motorola E 2020

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core (4x1.8 GHz Kryo 250 Gold & 4x1.8 GHz Kryo 250 Silver)
CHIPSET | Qualcomm SDM632 Snapdragon 632
GPU     | Adreno 506
Memory  | 2GB
Shipped Android Version | 10 (Q)
Storage | 32GB
Battery | 3550 mAh
Dimensions | 159.8 x 76.6 x 8.7 mm
Display | 720 x 1520 pixels, 6.2" IPS LCD
Rear Camera  | 13 MP (f/2.0) + 2 MP (f/2.2) (PDAF)
Front Camera | 5 MP (f/2.0)

![Device Picture](https://fdn2.gsmarena.com/vv/pics/motorola/motorola-moto-e-2020-1.jpg)

### Kernel Source
Check here: https://github.com/ixmoe/android_kernel_motorola_sdm632

### How to compile

```sh
. build/envsetup.sh
lunch omni_ginna-eng
make -j4 recoveryimage
```

### Copyright
 ```
  /*
  *  Copyright (C) 2013-20 The OmniROM Project
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
  ```
