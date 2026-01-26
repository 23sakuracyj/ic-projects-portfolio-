# AXI-Lite to SPI EEPROM Controller with Virtual Device

## Project Overview

This project implements a complete **AXI-Lite to SPI controller system** together with a **virtual SPI EEPROM device**, targeting FPGA-based system integration on the PL side.

The design enables **continuous read and write access** to a virtual EEPROM through an AXI-Lite interface, without relying on AXI burst transactions. The system integrates custom-designed AXI control logic, SPI master and slave modules, FIFO buffering, and software drivers running on the PS side.

All hardware modules are implemented in **pure Verilog**, except for standard PLL and ROM IPs provided by the FPGA toolchain.

---

## System Architecture

The overall system adopts a **layered architecture**:

PS (Software)
↓ AXI-Lite
AXI Control Layer
↓
SPI Frame Control Layer
↓
SPI Master
↓
Virtual SPI EEPROM (Slave)

The PS configures the controller through AXI-Lite registers, including:
- EEPROM start address
- Transfer length
- SPI clock divider
- Read / write control commands

Once triggered, the PL-side logic autonomously completes the SPI transaction and signals completion back to the PS.

---

## Design Features

- AXI-Lite based control interface  
- Custom SPI master (CPOL = 0, CPHA = 0, Mode 0)  
- Virtual EEPROM device with **15-bit address, 8-bit data width**  
- FIFO-based buffering for continuous data transfer  
- Continuous read/write without AXI burst support  
- Configurable SPI clock frequency  
- Full simulation and FPGA on-board verification  

---

## Hardware Design

### 1. Top-Level Module

**`top_axi_eeprom_spi_sim`**

- Wraps all submodules
- Exposes internal SPI signals for debugging
- Provides AXI-Lite interface to the PS

This module serves as the integration point for simulation and FPGA testing.

---

### 2. AXI Command Layer

**`axi_lite_eeprom_spi_core32`**

This module implements the AXI-Lite slave interface and defines the control and status registers.

#### Register Map

| Address | Name   | Description |
|------|--------|------------|
| 0x00 | CTRL   | bit0: EN<br>bit1: GO_WR<br>bit2: GO_RD |
| 0x04 | DIV    | SPI clock divider (div_half) |
| 0x08 | ADDR   | EEPROM access address (15-bit) |
| 0x0C | WDATA  | TX FIFO write data (8-bit) |
| 0x10 | RDATA  | RX FIFO read data (8-bit) |
| 0x14 | STATUS | busy, done, TX/RX full & empty |
| 0x18 | LEN    | Continuous transfer length |

The module includes an internal FSM to manage read/write initiation, busy signaling, and completion handling.

---

### 3. SPI Frame Control Layer

**`eeprom_frame_ctrl`**

This module defines the SPI frame format and manages byte-level sequencing:

- Command byte (read/write)
- High address byte
- Low address byte
- Data byte(s)

During a write operation, data bytes are fetched from the TX FIFO and sent sequentially.
During a read operation, dummy bytes are transmitted to generate SPI clocks, and received data is pushed into the RX FIFO.

The EEPROM internal address auto-increments while CS remains active, enabling continuous access.

---

### 4. SPI Master

**`spi_master_minimal_mode0`**

- Implements SPI Mode 0 (CPOL = 0, CPHA = 0)
- Byte-oriented transmission
- MSB-first shifting
- Configurable clock divider

Operation summary:
- Drives MOSI on SCLK falling edge
- Samples MISO on SCLK rising edge
- Asserts `busy` during transfer
- Generates a single-cycle `done` pulse after each byte

---

### 5. Virtual SPI EEPROM (Slave)

**`eeprom_spi`**

The virtual EEPROM emulates basic EEPROM behavior:

- 4 KB internal memory
- No erase operation (virtual device assumption)
- 15-bit address space
- Automatic address increment during continuous access

The slave FSM:
- Parses command and address bytes
- Handles byte-wise read or write
- Outputs data on MISO during read operations
- Resets internal state when CS is deasserted

---

## Software Design (PS Side)

The software driver provides:
- Single-byte read/write functions
- Continuous read/write functions
- Configurable SPI clock divider and transfer length

The PS writes configuration and data through AXI registers, triggers the operation, and retrieves received data from the RX FIFO once the `done` flag is asserted.

---

## Verification and Results

### Pre-Synthesis Simulation

- Verified correct SPI timing and protocol behavior
- Confirmed continuous read/write functionality
- FIFO operation validated under multiple transfer lengths

### FPGA On-Board Testing

- Single and continuous read/write operations verified
- User-configurable SPI speed tested successfully
- Data integrity maintained across address ranges

The system reliably supports continuous access without AXI burst transactions, relying on FIFO buffering and EEPROM auto-increment behavior.

---

## Tools and Environment

- Verilog HDL
- FPGA development environment (Vivado)
- AXI-Lite interconnect
- PLL and ROM IP cores
- On-board logic analyzer for debugging

---

## Known Limitations

- Virtual EEPROM only (no erase cycle modeling)
- FIFO depth fixed at 4 KB
- No error detection or retry mechanism
- Designed for functional validation rather than production deployment

---

## Author Contribution

This project was completed **independently**.

All RTL design, simulation testbenches, AXI register definition, SPI protocol implementation, and software driver development were performed by the author.
