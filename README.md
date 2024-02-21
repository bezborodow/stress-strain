# Stress-strain Plotter

This utility will graph a stress-strain plot with [GNU Octave](https://octave.org/). [MATLAB](https://www.mathworks.com/products/matlab.html)-compatible.

## Prerequisites

```
sudo apt install octave-statistics octave-matgeom
```

## Usage

An example plot will give the following output.

```
$ octave-cli stress.m examples/St1594.csv
St1594
E = 159.5514e+009
y =

     4.0547e-03   327.8306e+00

UTS = 497.0183e+000
Ur = 336.7970e+003
Ut = 176.4531e+006
UrA = 976.8397e+003
Ury = 664.6275e+003
```

**E** = modulus of elasticity, **y** = yield point, **UTS** = ultimate tensile strength (MPa), **Ur** = resilience, **Ut** = toughness, **UrA** = resilience calculated by area using [`trapz`](https://au.mathworks.com/help/matlab/ref/trapz.html), **Ury**, resilience calculated by yield point.

A stress strain curve will be plotted:

![St1594 stress-strain](/examples/St1594.svg)

Additionally, a subplot of the linear region will provide greater detail of the elastic properties of the material:

![St1594 stress-strain (linear region)](/examples/St1594_1.svg)

The data in these examples were obtained from an [Instron universal testing machine](https://www.instron.com/en/resources/test-types/tensile-test).

![St1594 stress-strain (linear region)](/examples/IMG_20220908_114042.jpg)

## Author

2022 Damien Bezborodov

This software is in the public domain "AS-IS," without warranty and without liability.
