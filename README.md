# ATmega328P assembly exercises

Earlier embedded programming work by **Ali Faour**, covering register-level I/O, arithmetic, display control, and serial transmission on the ATmega328P. Each folder is an independent AVR assembly project with its own `main.asm` and Atmel Studio solution.

[Portfolio and current engineering work](https://cyberfaour.github.io/Portfolio/)

## Explore the projects

The descriptions below identify the exercises present in the source. They are not claims that every checked-in program has been rebuilt or verified on hardware.

| Project | Source to inspect | Focus |
| --- | --- | --- |
| LCD interface | [LCD_ATMEGA328P/main.asm](LCD_ATMEGA328P/main.asm) | LCD initialization, command/data signalling, cursor positioning, text stored in program memory, and software delays. |
| UART communication | [UART_Communication/main.asm](UART_Communication/main.asm) | Baud-rate register setup, transmitter readiness polling, and repeated transmission of the character `a`. |
| Binary display | [Binary Display of Decimals/main.asm](Binary%20Display%20of%20Decimals/main.asm) | An 8-bit decrementing value written to `PORTD`, with delays to make output changes visible. |
| Arithmetic and logic | [Arithmatics_ASM/main.asm](Arithmatics_ASM/main.asm) | Input-selected addition, subtraction, multiplication, AND, OR, and XOR using fixed operands. |
| Seven-segment display | [AssemblerApplication1/main.asm](AssemblerApplication1/main.asm) | Digit bit patterns and forward/reverse display sequencing through `PORTD`. |
| Button and LED control | [Pullup_Pulldown_LED/main.asm](Pullup_Pulldown_LED/main.asm) | Pin tests and output changes for pull-up/pull-down input exercises. |

For a first code review, start with the UART project, then inspect the LCD routines to see the larger register-level interface.

## Toolchain and project format

The `.asmproj` files specify:

- **Device:** ATmega328P.
- **Project format:** Atmel Studio 7.0.
- **Toolchain:** `com.Atmel.AVRAssembler`.
- **Device definitions:** `m328Pdef.inc`, supplied through project settings.
- **Device-pack include path:** the original projects reference `ATmega_DFP/1.7.374`; adapt the include path to the device pack installed on your machine.

Use an environment that can open the supplied `.atsln`/`.asmproj` files and provides this assembler and the ATmega328P device definitions. The repository does not contain a portable command-line build script.

## Open and inspect locally

1. Clone the repository and open one project's `.atsln` file, for example [UART_Communication.atsln](UART_Communication/UART_Communication.atsln).
2. Confirm the ATmega328P target and resolve the device-pack include path in the project settings.
3. Build that project and review the assembler output. The projects are independent; there is no repository-wide solution.
4. Use the IDE's simulator/debugger where available to inspect register values and execution before preparing a hardware demonstration.

The repository does not include a complete schematic, board definition, fuse configuration, or reproducible hardware test procedure. Select and verify those for your own setup before programming a device.

## Interface details visible in the source

| Example | Mapping or assumption |
| --- | --- |
| LCD data | Writes an 8-bit value to `PORTD`. |
| LCD control | Uses `PORTB.0` for register select and `PORTB.1` for enable. |
| LCD timing | Delay comments assume a 16 MHz clock; timing has not been remeasured. |
| UART timing | Defines a 16 MHz clock and 9,600 baud, then calculates the baud-rate divider. |
| UART scope | Enables transmit and receive, but the demonstration loop only transmits; it does not implement received-message processing. |

These are source mappings, not a complete wiring guide. In particular, the LCD source reads `PINC` while configuring `DDRC` as outputs; its input handling needs review before reproducing the intended controls.

## Status and limitations

This repository preserves learning-stage source, including unfinished routines and original IDE/build files. GPIO direction, branching, display sequencing, and delay logic need verification when reproducing the exercises. A clean build and physical hardware behavior have not been revalidated for this snapshot.

The LCD's **CGRAM/custom-character routines are commented out**. They should be treated as an unfinished experiment, not as a working custom-character feature.

My contribution represented here is the assembly exercise code and project setup. For current industrial software, automation, and AIoT projects, see the [portfolio](https://cyberfaour.github.io/Portfolio/).
