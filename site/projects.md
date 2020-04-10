## Futil
[Futil][futil] is the Fused Temporal Intermediate Language. It is a novel *self-contained* intermediate representation for [High-level Synthesis][hls]. HLS is the process
of compiling languages that are semantically close to
traditional software languages (C, C++ are the languages typically chosen for this)
into digital circuit designs that can be run on an FPGA or fabricated. The goal is to
speed up the time-consuming process of digital circuit design by raising the level of
abstraction. 

However, there is a large semantic gap between software languages and digital
circuits. The most popular HLS compilers today work by first using existing tools 
to transform an input C++ program into LLVM. LLVM programs are in [SSA][ssa] and so
basic blocks describe dataflow graphs. These graphs basically look like hardware graphs where
dataflow edges represent either a register or a wire, but all the operations are *logical*
and *untimed*. *Scheduling* transforms the logical untimed operations to logical *timed*
operations and *binding* assigns each logical operation physical resources. These stages
can potentially affect each other, and so they are performed some number of times until
we are left with a timed program that uses physical resources.

At it's core, Futil is a self-contained representation that allows these standard
algorithms to be expressed as a series of modular passes. We believe that this will make
HLS compilers both easier to write and easier to extend. We think that extensibility
is especially important because it can accelerate the speed of HLS research by
making it much easier to test out new algorithms and explore new input languages.

[Here][futil-paper] is a paper that we wrote that goes into more depth on that language.
You can even play around with the compiler online: [Demo][futil-demo].

## Polka
[Polka][] is a simple and extensible framework for keeping a single set of dot files

[futil]: https://github.com/cucapra/futil
[futil-paper]: /papers/futil.pdf
[futil-demo]: /futil-demo
[dahlia]: https://github.com/cucapra/dahlia
[hls]: https://en.wikipedia.org/wiki/High-level_synthesis
[ssa]: https://en.wikipedia.org/wiki/Static_single_assignment_form
[polka]: https://github.com/sgpthomas/polka
