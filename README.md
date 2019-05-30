This README file is in github markdown.

# Welcome to real-Forth

This is real-Forth, a descendant of fig-Forth, for the 8086 *et al*. It runs on top of MS-DOS or an MS-DOS clone such as Free-DOS. Like fig-Forth, it is a traditional indirect threaded Forth. It uses screen files to emulate Forth's traditional raw block access to floppy or hard drives.

It includes fastForth, a direct JSR/BSR threaded Forth for the 68000 and Atari ST.

For more information on the differences between these Forths and fig-Forth, see the chapter on Pedigree in the real-Forth User's Guide.

The attendant screen files contain many utilities and sample programs. Assemblers, disassemblers, and editors are all standard.

# Running the Products

Both are known to run on a modern Linux, using an appropriate emulator. Both ran on operating systems of their day, such as TOS 1.04 on the Atari and MS-DOS on the PC.

More recently,

* The 8086 real-Forth runs on FreeDOS 1.2, on top of a qemu VM with a 4 GB virtual disk.

* FastForth runs on Hatari v2.1.0, using EmuTOS version 9.10 or later.

# Licensing

The license is the [3-Clause BSD License](https://opensource.org/licenses/BSD-3-Clause). The [SPDX](https://spdx.org) short identifier is BSD-3-Clause. A copy of the license is included in the distribution.

# Installation

Screen files are not very friendly to version control systems like [git](https://git-scm.com/). To solve that problem, we store the screen files (extension .scr) as text files (.scn). To convert, use the program scr2scn.pl, available at pretty much the same place you got real-Forth, [https://github.com/charlescurley/scr2scn](https://github.com/charlescurley/scr2scn).

So the first job is to convert the text files to screen files.

    scr2scn.pl *.scn

Now follow the instructions below for your target machine. Or you may have to be creative if you are using a different VM or computer to run the program.

## MS-DOS

Use something like the file `mount.qcow2.sh` (in the `msdos` directory of this repo) to mount your MS-DOS drive. You may need the package `qemu-nbd`. You may have to edit the user name of your user and the path to the file of the virtual disk. You may want to install it in root's path.

Create a directory on the virtual machine's hard drive, say `\rf`. Copy the Forth executable (`RFF.COM`) and any screen files into that directory.

    cp RFF.COM *.SCR *.scr /mnt/RF

You may also wish to create a batch file, `RF.BAT`, to launch real-Forth, and put that in your path.

```batchfile
c:
cd \rf
rff 3 load cr filing cr ."  iok"
```

Now unmount and disconnect the virtual disk:

    umount /mnt && partx --delete /dev/nbd0 && qemu-nbd --disconnect /dev/nbd0

You should now be able to boot the virtual machine and run real-Forth.

When running either Forth for the first time, use `9 load` to compile the utilities overlay for the first time. Thereafter, `3 load` will bring them in.

## Atari ST

### Hatari Emulator

fastForth is know to work with the Hatari emulator. It is set up to emulate an Atari Mega ST with 2 MB of RAM, and three disk partitions. The first two are ASCI 32 MB partitions built per Hatari instructions. The third is a GEMDOS drive, useful for copying files into and out of the first two partitions. It is essential to emulate a 68000 because the fastForth trap handlers are for 68000. Trap handlers for later versions of the 680x0 family would be welcome. Feel free to crank the emulated CPU up to 32MHz.

fastForth will run in color or monochrome mode. If it finds the computer in 16 color mode, it will force the resolution to four color mode, better for software development. It does not return the resolution to 16 color mode on exit. For this reason, four color mode is preferable.

### XSteem

fastForth also works with XSteem 3.7.2. However, XSteem is not available for Debian, and is for 32 bit Linux only. I anticipate no further compatibility testing.

### Setup

Create a directory in the root of your GEMDOS drive, say `ff`. Then copy the executable and screen files in to it.

    cp *.TTP *.SCR *.scr .../ff

Boot the Hatari. Use GEM to copy the directory from the GEMDOS drive to one of your ASCI drives. Enter the directory. Double click on `FAST4TH.TTP`. You may enter a useful command line, such as `3 load`, or not, as you wish.

When running either Forth for the first time, use `9 load` to compile the utilities overlay for the first time. Thereafter, `3 load` will bring them in.

For more information, see the section on booting on the Atari in the User Documentation for fastForth.

