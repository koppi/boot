# boot

A minimal x86 bootloader and educational project for low-level programming.

## Overview

This repository provides a simple bootloader implementation, designed as a learning resource for understanding how operating systems start up and interact with hardware at the lowest level. It is intended for hobbyists, students, and anyone interested in x86 assembly, boot sectors, and early-stage OS development.

## Features

- Minimal x86 bootloader code
- Educational and well-commented source
- Simple and clean project structure
- Uses AT&T syntax (GNU Assembler - GAS) for assembly instructions

## Getting Started

### Prerequisites

- x86 emulator (e.g., QEMU)
- GNU assembler (GAS, part of GNU binutils)
- Make (for automated builds, a Makefile is provided)

### Building

1. Clone the repository:
    ```sh
    git clone https://github.com/koppi/boot.git
    cd boot
    ```

2. Build the bootloader and run it in QEMU:
    ```sh
    make
    ```
## Project Structure

- `boot.s` - Main bootloader source (AT&T syntax)
- `Makefile` - Build automation

## Contributing

Contributions, suggestions, and improvements are welcome! Please open issues or pull requests.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Author

- [koppi](https://github.com/koppi)
