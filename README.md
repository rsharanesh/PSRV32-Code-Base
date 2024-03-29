# PSRV32-Code-Base

The Private Code base that has been used for PSRV32 Processor.

## Note or Standard Points for All Stages

-   Reads are always Combinational, Writes are sequential
-   Have a common clock signal across all the modules with name **clk**
-   In all the flowcharts attached below the following convention is being held: _we highlight the right half of registers or memory when they are being read and highlight the left half when they are being written_

## Designing the Pipeline flow

-   There are registers at the junction between any two stages of the pipeline so that the data from one stage of the pipeline reaches the next stage.

## 5-Stages of the Pipeline for a _load_ instruction

-   In any stage of the pipeline the pipeline registers should hold the values of control signals and other data points required for that instruction in the current pipeline stage as well as required by the other stages of the pipeline.
-   This becomes more evident in the case of _load_ instructions, in earier cases we had the write register address decoded from decode register itself, till the full cycle exceution comes snd finally completes the write. But as we implement pipeline, the next instruction in decode stage will overwrite it's value and makes the earlier value to disapper, so when the WB stage of the ealrer intructions put data on the write data line the address isn't correct. So we need to pass on the Write register address along with other values passed from one stage to other till the WB stage and while we are updating the it, the address will be bought in from the MEM/WB pipleined register.

1. **_Instruction fetch:_** The top portion of Figure 4.36 shows the instruction being read from memory using the address in the PC and then being placed in the IF/ID pipeline register.The PC address is incremented by 4 and then written back into the PC to be ready for the next clock cycle. This incremented address is also saved in the IF/ID pipeline register in case it is needed later for an instruction,such as beq. The computer cannot know which type of instruction is being fetched, so it must prepare for any instruction, passing potentially needed information down the pipeline.

2. **_Instruction decode and register file read:_** The bottom portion of Figure 4.36 shows the instruction portion of the IF/ID pipeline register supplying the 16-bit immediate field, which is sign-extended to 32 bits, and the register numbers to read the two registers. All three values are stored in the ID/EX pipeline register, along with the incremented PC address. We again transfer everything that might be needed by any instruction during a later clock cycle.

3. **_Execute or address calculation_**: Figure 4.37 shows that the load instruction reads the contents of register 1 and the sign-extended immediate from the
   ID/EX pipeline register and adds them using the ALU. That sum is placed in the EX/MEM pipeline register.

4. **_Memory access:_** The top portion of Figure 4.38 shows the load instruction reading the data memory using the address from the EX/MEM pipeline register and loading the data into the MEM/WB pipeline register.

5. **_Write-back:_** The bottom portion of Figure 4.38 shows the final step: reading the data from the MEM/WB pipeline register and writing it into the register file in the middle of the figure.

### Final Pipeline Control+Datapath

![image](https://user-images.githubusercontent.com/64090461/127973794-6788ecbb-c25b-4304-9fd5-c17138abe390.png)

The below figure depicts the control unit of the pipelined processor
!![image](https://user-images.githubusercontent.com/64090461/128132304-a5c9bb69-fdd9-4718-a1ff-cb36cae16c5c.png)

The hence-forth figure shows the complete description of the 5-Stage pipelined processor alongwith the required control signals pertaining to each stage of the pipeline.
![image](https://user-images.githubusercontent.com/64090461/128133281-7fe4500e-331a-4585-94c4-5ee8121e3bab.png)

### Single cycle Processor Control+Datapath

The figure below shows the description of a simple processor (operates only on R-type, Load/Store and Branch instructions) design without pipelining for RV32I based implementation without pipelining.
![image](https://user-images.githubusercontent.com/64090461/128110276-a844d89f-4e30-40e9-911f-cb2f222c8954.png)

The same aboved processor extended to implement jump instructions as well
![image](https://user-images.githubusercontent.com/64090461/128113806-cc7db23b-0b7f-466d-95c0-0c3280e972bb.png)

### Pipeline+Datapath only for a load instruction

![image](https://user-images.githubusercontent.com/64090461/128129210-965a0cc1-7e60-4204-8f7f-7043cf1aa4ab.png)

### Hazard Detection unit

-   Should be able to manage all the hazards, i.e either forward or stall accordingly.

-   Load-Data hazard : Should Stall for one cycle. -![image](https://user-images.githubusercontent.com/64090461/128115271-d7c425bf-547c-4f72-84c9-3040164a87cb.png)

-   Exc-Data hazard : Should do forwading.
-   ![image](https://user-images.githubusercontent.com/64090461/128115241-2dd09047-0854-41d2-83d1-a93461a66c5c.png)

### Fowarding Condtions

1. EX Hazard : Forwarding the value from EX to other subsequent cases
   ![image](https://user-images.githubusercontent.com/64090461/128159688-72794828-5d9c-49e8-9e5f-70ac0bdc7a1c.png)

![image](https://user-images.githubusercontent.com/64090461/128159864-4e9ecd90-259a-48e5-af29-89bec75b7122.png)

![image](https://user-images.githubusercontent.com/64090461/128159899-896ae9a1-acb9-460f-9fb4-b4d2c64178a0.png)

2. MEM Hazard
   ![image](https://user-images.githubusercontent.com/64090461/128160011-478033de-d84e-4134-ac97-2abd5c81eba8.png)

![image](https://user-images.githubusercontent.com/64090461/128160051-5411e045-6372-4f1a-9b97-f1c035fb5663.png)

### Hazard's Conditions

1. When R-type occurs following a load : in this case the pipeline must stall for one cycle

![image](https://user-images.githubusercontent.com/64090461/128160362-069001d8-214d-4fc6-82db-b6012806ff1f.png)

Also in this case when an hazard is being detected then all the pipelined registers must be flushed.

![image](https://user-images.githubusercontent.com/64090461/128160581-775261c3-7723-4a66-a391-1e4a1e86c617.png)
