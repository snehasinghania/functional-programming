MODULAR DESIGN
Software systems grow to be significantly complex. Except for the most trivial
systems, it is usually imposible to develop the entire system as a monolithic
piece. Even if we succeed to do so, such systems are very difficult to understand
and maintain for those who have to work with this piece of code. Therefore, it
is an essential engineering practice to decompose the problem so that the
invidual sub-problems can be solved separately. Another reason for modularising
code is to facilitate re-use and avoid rework. This means that common pieces of
code should be lifted out of separate modules and placed in a separate module, 
which then can be used by several modules as required.

To complete the solution
all individual solutions must come together to become parts of a single solution
at the end. Therefore, they must interact through clearly defined interfaces.

The lexical analyser is composed of a number of modules, viz.
- Mystream: Implements the input stream
- State: Implements the return type for the scanners
- Id: Implements the scanner for identifiers
- Num: Implements the scanner for decimal numbers
- Lexer: Implements the top-level lexical analyser

UNIT TESTING
After a module is developed, it must be tested before it is integrated with
other modules. As you will find here, each important module <mod>.ml in the given code
comes with a testing module test_<mod>.ml.
