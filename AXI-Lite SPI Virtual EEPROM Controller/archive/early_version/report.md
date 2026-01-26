# Design Archive – Early Versions and Deprecated Implementations

This document records **early design iterations** of the AXI-Lite to SPI EEPROM
controller project.  
The archived versions represent exploratory implementations developed prior to
the final integrated SoC-level design.

These versions are preserved for **design traceability and verification history**,
but are **not used in the current system architecture**.

---

## Overview of Archived Versions

The `archive/early_version/` directory contains three archived packages:

- `EEPROM.zip` – standalone SPI EEPROM module  
- `test.zip` – SPI master / host-side test implementation  
- `test2.zip` – SPI slave / device-side test implementation  

Each version targets a **specific development stage** and was used to validate
individual functional blocks before full system integration.

---

## 1. `EEPROM.zip` – Standalone SPI EEPROM Module

### Design Purpose

This version implements a **standalone virtual SPI EEPROM module**, without any
connection to an SoC or AXI-based control interface.

The design objective was to:
- Establish a correct SPI slave protocol implementation
- Validate command decoding and address handling
- Verify internal memory read/write behavior
- Serve as a reusable functional baseline for later integration

### Key Characteristics

- SPI slave implementation (Mode 0)
- Internal memory array (byte-addressable)
- Support for basic read and write commands
- No AXI interface or FIFO buffering
- Operates independently of any host processor

### Limitations

- No integration with AXI or SoC-level control logic
- No support for continuous transfer triggered by software
- Intended only for functional validation at the protocol level

### Outcome

This version successfully verified the **correctness of the SPI EEPROM behavior**
and was later used as the foundation for the integrated virtual EEPROM in the
final system.

---

## 2. `test.zip` – Host-Side (Master) Test Implementation

### Design Purpose

This version focuses on **testing the SPI master (host) side**, independent of a
complete SoC environment.

The goal was to:
- Validate SPI master timing and control FSM
- Verify correct generation of MOSI, SCLK, and CS signals
- Test byte-level transmission and reception
- Debug clock divider and transfer sequencing logic

### Key Characteristics

- SPI master implementation
- Simple testbench-driven stimulus
- No AXI-Lite interface
- No FIFO-based buffering
- Direct control of SPI transactions

### Limitations

- Not connected to an SoC or PS-side software
- No register-mapped control interface
- Limited scalability for continuous transactions

### Outcome

This version enabled **isolated verification of the SPI master logic** and
facilitated early debugging before introducing AXI control and FIFO buffering.

---

## 3. `test2.zip` – Device-Side (Slave) Test Implementation

### Design Purpose

This version is dedicated to **testing the SPI slave (EEPROM) side**, acting as a
standalone verification environment for the virtual device.

The design objective was to:
- Verify SPI slave FSM behavior under various command sequences
- Validate address parsing and auto-increment behavior
- Confirm correct MISO timing and data output
- Test robustness against CS toggling and frame boundaries

### Key Characteristics

- SPI slave-only design
- Focused FSM for command, address, and data phases
- Independent of AXI, FIFO, or host-side control logic
- Testbench-driven verification

### Limitations

- No SoC-level integration
- No interaction with AXI-Lite or software drivers
- Intended solely for protocol-level validation

### Outcome

This version provided confidence in the **correctness and robustness of the SPI
slave implementation**, which was later integrated into the final virtual EEPROM.

---

## Design Evolution Summary

The archived versions reflect a **bottom-up development strategy**:

1. Validate SPI slave behavior (`EEPROM.zip`)
2. Validate SPI master behavior (`test.zip`)
3. Independently verify device-side protocol handling (`test2.zip`)
4. Integrate verified modules into a unified AXI-Lite–controlled system

This staged approach reduced integration risk and simplified debugging during
later SoC-level development.

---

## Notes

These archived implementations are retained to document the **design evolution**
and decision-making process.  
They are not intended for direct reuse but serve as reference material and
verification evidence for the final integrated design.
