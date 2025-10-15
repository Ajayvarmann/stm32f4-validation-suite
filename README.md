# STM32F4 Hardware Validation Suite (Renode + Robot Framework)

### Overview
A complete virtual hardware validation environment for the **STM32F4 Discovery Board** using **Renode 1.16** and **Robot Framework 7.0**.  
It simulates UART, I²C, SPI, and a virtual DC-DC converter (PMBus) to demonstrate hardware-in-the-loop testing and automated fault injection.

### Structure
| Folder | Purpose |
|---------|----------|
| `firmware/` | STM32 C code (HAL-based) |
| `renode/` | Board definition and PMBus model |
| `tests/` | Robot Framework test scripts |
| `docs/` | Validation manual & self-assessment |
| `results/` | Logs & screenshots |

### Tools Required
- **Renode ≥ 1.16**
- **Python ≥ 3.9**
- **Robot Framework ≥ 7.0**
- **Git + GitHub CLI**

### Run Tests
```bash
robot -d results tests/
