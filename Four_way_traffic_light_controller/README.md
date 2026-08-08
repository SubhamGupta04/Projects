# 4-Way Traffic Light Controller Using Verilog HDL

## Overview

This project implements a **4-way traffic light controller using Verilog HDL** on the **Digilent Nexys 4 Artix-7 FPGA development board**.

The controller manages traffic signals for four directions:

- North
- East
- South
- West

Each direction has three traffic signals:

- Green
- Yellow
- Red

A **Finite State Machine (FSM)** is used to control the traffic-light sequence. A countdown timer displays the remaining time of the current state on the Nexys 4's **7-segment display**.

The system uses the onboard **100 MHz clock** and generates:

- **1 Hz clock** for traffic-light timing
- **500 Hz clock** for 7-segment display multiplexing

---

## Hardware Used

- Digilent Nexys 4 Artix-7 FPGA Development Board
- Xilinx Artix-7 FPGA
- 100 MHz onboard oscillator
- 12 LEDs
- 8-digit common-anode 7-segment display
- CPU reset push button
- USB connection for FPGA programming

---

## Software Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator (optional)
- XDC constraint file

---

## Features

- 4-way traffic-light control
- FSM-based traffic controller
- 8 traffic-light states
- 15-second Green signal
- 5-second Yellow signal
- Automatic traffic-light sequencing
- Countdown timer on 7-segment display
- 1 Hz traffic-control clock
- 500 Hz display multiplexing clock
- Active-high reset
- Synthesizable Verilog HDL
- FPGA implementation on Nexys 4 Artix-7

---

# System Architecture

The overall system can be represented as:

                    100 MHz Clock
                         |
                         v
                +----------------+
                | Clock Divider  |
                +----------------+
                    |          |
                  1 Hz       500 Hz
                    |          |
                    v          v
            +-------------+  +----------------+
            | Traffic FSM |  | 7-Segment MUX  |
            |             |  |                |
            | Countdown   |  | Display Driver |
            +------+------+  +-------+--------+
                   |                 |
                   v                 v
             12 Traffic LEDs   7-Segment Display


The design consists of three main sections:

1. Clock Divider
2. Traffic Light FSM and Countdown Timer
3. Seven-Segment Display Multiplexer

---

# Traffic Light Sequence

The controller follows this sequence continuously:

                    NORTH GREEN
                         |
                         v
                   NORTH YELLOW
                         |
                         v
                    EAST GREEN
                         |
                         v
                   EAST YELLOW
                         |
                         v
                   SOUTH GREEN
                         |
                         v
                  SOUTH YELLOW
                         |
                         v
                    WEST GREEN
                         |
                         v
                   WEST YELLOW
                         |
                         +----------> NORTH GREEN


Only one direction is allowed to have Green or Yellow at a time.

All other directions remain Red.

---

# Traffic Light Timing

The default timing values are:

| Traffic State | Duration |
|---------------|----------|
| Green         | 15 seconds |
| Yellow        | 5 seconds |

The timing values are defined in the Verilog code:

```verilog
integer GREEN_TIME = 15;
integer YELLOW_TIME = 5;
