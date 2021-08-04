# PSRV32-Code-Base
The Private Code base that has been used for PSRV32 Processor.


## Note or Standard Points for All Stages
- Reads are always Combinational, Writes are sequential
- Have a common clock signal across all the modules with name **clk**
- In all the flowcharts attached below the following convention is being held: *we highlight the right half of registers or memory when they are
being read and highlight the left half when they are being written*

## Designing the Pipeline flow
- There are registers at the junction between any two stages of the pipeline so that the data from one stage of the pipeline reaches the next stage.

## 5-Stages of the Pipeline
1. ***Instruction fetch:*** The top portion of Figure 4.36 shows the instruction being read from memory using the address in the PC and then being placed in the IF/ID pipeline register.The PC address is incremented by 4 and then written back into the PC to be ready for the next clock cycle. Th is incremented address is also saved in the IF/ID pipeline register in case it is needed later for an instruction,such as beq. The computer cannot know which type of instruction is being fetched, so it must prepare for any instruction, passing potentially needed information down the pipeline.

2. ***Instruction decode and register file read:*** The bottom portion of Figure 4.36 shows the instruction portion of the IF/ID pipeline register supplying the 16-bit immediate field, which is sign-extended to 32 bits, and the register numbers to read the two registers. All three values are stored in the ID/EX pipeline register, along with the incremented PC address. We again transfer everything that might be needed by any instruction during a later clock cycle.

3. 
### Final Pipeline Control+Datapath
![image](https://user-images.githubusercontent.com/64090461/127973794-6788ecbb-c25b-4304-9fd5-c17138abe390.png)

### Single cycle Processor Control+Datapath
The figure below shows the description of a simple processor (operates only on R-type, Load/Store and Branch instructions) design without pipelining for RV32I based implementation without pipelining.
![image](https://user-images.githubusercontent.com/64090461/128110276-a844d89f-4e30-40e9-911f-cb2f222c8954.png)

The same aboved processor extended to implement jump instructions as well
![image](https://user-images.githubusercontent.com/64090461/128113806-cc7db23b-0b7f-466d-95c0-0c3280e972bb.png)

### Hazard Detection unit
- Should be able to manage all the hazards, i.e either forward or stall accordingly.
- Load-Data hazard : Should Stall for one cycle. 
-![image](https://user-images.githubusercontent.com/64090461/128115271-d7c425bf-547c-4f72-84c9-3040164a87cb.png)

- Exc-Data hazard : Should do forwading. 
- ![image](https://user-images.githubusercontent.com/64090461/128115241-2dd09047-0854-41d2-83d1-a93461a66c5c.png)

