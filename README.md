Mini Bootable system
---

## 🛠️ Compiling requirements

Requirements to compile this system:

### 1. System requirements
* **Linux**/Windows/MacOS X based OS.
* 16-bit system (If you are going to run the binary file on a real hardware)

### 2. Assembler
You will need NASM.

### 3. Emulator (Optional)
If ur gonna run the binary files:

* **Qemu**
* **Bochs**
* **VMware**
* **VirtualBox**
Is the recommended virtualization tools.

---

## 🚀 How-To-Start

### Setup and install your assembler

### Debian (nasm)
```bash
sudo apt install nasm
```

### Arch Linux (nasm)
```bash
sudo pacman -S nasm
```

### Windows and MacOS X (nasm)
```
https://www.nasm.us/pub/nasm/releasebuilds/ :: Visit this URL to download NASM on your Windows machine.
```

### Compiling the project
Let's clone this project:

```bash
git clone https://github.com/alexlawrence/katze.git
cd katze
```

Compiling with NASM:

```bash
cd katze/fasm-syntax
nasm -f bin boot16.asm -o katze
dd if=katze of=katze.img
```

## Reverse engineering

### Nasm:

```bash
ndisasm katze
```

### Fasm:

```bash
xxd katze.bin
```

Veya:

```bash
hexdump -C katze.bin
```

## Thanks to....
My Turkish friend, Kenan. Thanks to him, this system is based off BeriliumOS. Again, special thanks to Kenan!
