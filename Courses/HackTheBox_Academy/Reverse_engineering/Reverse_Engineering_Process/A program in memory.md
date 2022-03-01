# A program in memory
## Kernel mode VS User mode
- In user-mode, an application starts a user-mode process which comes with its own private virtual address space and handle table.
- In kernel mode, application share virtual address space.
- https://docs.microsoft.com/en-us/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode

## The stack
- Data is either pushed onto or popped off of the stack dtata structure
- EBP - Base Pointer is the register that used to store the references in the stack frame

![[stack_frame.png]]

## Calling a function
![[calling_a_function.gif]]

## Local Variables on the stack
![[local_variables_on_the_stack.gif]]

## Example : Simple hello world 
![[Hello_world.gif]]