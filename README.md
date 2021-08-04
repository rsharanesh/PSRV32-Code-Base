# PSRV32-Code-Base
The Private Code base that has been used for PSRV32 Processor.


## Note or Standard Points for All Stages
- Reads are always Combinational, Writes are sequential
- Have  a common clock signal across all the modules with name **clk**

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

