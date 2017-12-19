# hammerspoon-dotfiles
Hammerspoon configuration I personally use to make macOS more productive.

## Features 
* custom shortcuts
* battery status notifications
* window tiling hotkeys
* window moving to other spaces

## Installation

First up, install [Hammerspoon](http://www.hammerspoon.org/) if you haven't already.

Follow the installation instructions for the required [Spaces Module](https://github.com/asmagill/hs._asm.undocumented.spaces#installation).

Then clone (or copy) `hammerspoon-dotfiles` into your hammerspoon directory:

```
cd $HOME/.hammerspoon
git clone https://github.com/reybok/hammerspoon-dotfiles .
```

### Enable Spaces Support

* Settings > Mission Control: disable `Automatically rearrange Spaces based on most recent use` 
* Settings > Mission Control: enable `Displays have separate Spaces` ![Screenshot Mission Control Settings](https://user-images.githubusercontent.com/32271425/33946879-42d88266-e023-11e7-974a-d4ee57776031.png)

* Settings > Keyboard > Shortcuts: enable Mission Control > Switch to Desktop `n` and set the hotkey to <kbd>mod</kbd>+<kbd>[n]</kbd> (see chapter Quick Start) ![Screenshot Keyboard Shortcuts](https://user-images.githubusercontent.com/32271425/33946878-42bd1990-e023-11e7-9dc9-d3a1bd532a43.png)

## Updating

To update to the latest configuration, pull from git:

```
cd $HOME/.hammerspoon
git pull
```

## Tutorial
There are several branches that accompany a short introductory talk ([download as PDF](https://github.com/reybok/hammerspoon-dotfiles/files/1571899/Wissensaustauschrausch_JN_macOS_scripting.pdf)) I held in 2017.
Checkout `tutorial01`, `tutorial02`, and `tutorial03` as you go along to see the incremental evolution. Finally, for space manipulation, check out the `tutorial04` branch.


## Quick Start
The default modifier (base key for every action) is <kbd>⌘</kbd>.
To change that, edit the `globals.lua` file found in `~/.hammerspoon/`.

## Hotkeys
The default modifier is abreviated with <kbd>mod</kbd> in the following list.

### Window Resizing

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>↩</kbd> : open new iTerm2 window

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>←</kbd> : move window to left half

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>→</kbd> : move window to right half

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>↑</kbd> : move window to top half

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>↓</kbd> : move window to bottom half

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>M</kbd> : maximize window

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>⌫</kbd> : return window to its size and position it was before using any hotkeys on it

### Window Moving

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>1</kbd> : move window to space 1

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>2</kbd> : move window to space 2

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>3</kbd> : move window to space 3

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>4</kbd> : move window to space 4

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>5</kbd> : move window to space 5

<kbd>mod</kbd>+<kbd>⇧</kbd>+<kbd>6</kbd> : move window to space 6

### Development

<kbd>⌘</kbd>+<kbd>⌥</kbd>+<kbd>^</kbd>+<kbd>R</kbd> : reload hammerspoon config

<kbd>⌥</kbd>+<kbd>^</kbd>+<kbd>7</kbd> : emit <kbd>⌘</kbd>+<kbd>\ </kbd>, which is used to line comment code in jetbrains products on German keyboards


## License
> MIT License
>
> Copyright (c) 2017 Jakob Niemeyer
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
