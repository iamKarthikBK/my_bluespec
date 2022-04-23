########################################################
Detailed explaination of a multiplier implemented in BSV
########################################################

====================
Interface defination
====================

We define an interface ``Mult_ifc`` that contains the declaration of the methods ``start`` and ``result``.

--------------------
The ``start`` method
--------------------

The ``start`` method is of type ``Action``, and accepts 2 parameters ``x`` and ``y``, both of the type ``int``.

.. code-block::SystemVerilog
    method Action start(x, y) if (...);
        ...
    endmethod: start


---------------------
The ``result`` method
---------------------

The ``result`` method is of type ``Value``, and does not accept any parameters, but returns a ``Value`` of type ``int``.

.. code-block::SystemVerilog
    method result() if (...);
        ...
    endmethod: result

=================
Module defination
=================

We define the ``mkMult1`` module which interfaces with ``Mult_ifc``.

.. code-block::SystemVerilog
    module mkMult1(Mult_ifc);
        ...
    endmodule: mkMult1

----------------
Storage elements
----------------

The ``mkMult1`` module uses three registers of type ``int``, namely ``product``, ``d``, ``r``. All three of these registers are initialised to ``0`` using ``mkReg(0)`` from the library.

.. code-block::SystemVerilog
    ...
    Reg#(int) product   <-  mkReg(0);
    Reg#(int) d         <-  mkReg(0);
    Reg#(int) r         <-  mkReg(0);
    ...

-----
Rules
-----

The ``mkMult1`` module contains a single rule ``cycle`` defined as follows:

.. code-block::SystemVerilog
    rule cycle(r != 0);
        if(r[0] == 1) product <= product + d;
        d <= d << 1;
        r <= r >> 1;
    endrule: cycle

This rule ``cycle`` fires only when contents of the register ``r`` are not ``0``.

==========
Top module
==========

The top module is defined as follows:

.. code-block::SystemVerilog
    module mkTest(Empty);
        ...
    endmodule: mkTest

We define a ``state`` register of type ``int``, and initialise it to ``0``.

.. code-block::SystemVerilog
    Reg#(int) state <-  mkReg(0);

-----------------------------------------------
Instantiating the DUT and binding the interface
-----------------------------------------------

We instantiate the DUT's interface (in this case, ``Mult_ifc``) and bind it to the module ``mkMult1``.

.. code-block::SystemVerilog
    Mult_ifc m  <-  mkMult1();

-----
Rules
-----

We write two rules ``go`` and ``finish`` in the top module.

.. code-block::SystemVerilog
    rule go(...)
        ...
    endrule: go

    rule finish(...)
        ...
    endrule: finish

The ``go`` rule fires only if ``state == 0``. It invokes the ``Action`` method ``start`` from the interface ``Mult_ifc`` with the values to be stored in the registers ``d`` and ``r``.

.. code-block::SystemVerilog
    rule go(state == 0)
        m.start(9, 5);
        state <= 1;
    endrule: go

The ``finish`` rule fires only if ``state == 1``. This rule simply displays the value present in the ``product`` register.

.. code-block::SystemVerilog
    rule finish(state == 1)
        $display("Product = %d", m.result());
        state <= 2;
    endrule: go

The ``finish`` rule invokes the ``result`` method of type ``Value`` from the DUT's interface, which returns the value stored in the ``product`` register of the ``mkMult1`` module insteantiated with the label ``m`` inside the top module.