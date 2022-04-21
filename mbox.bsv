interface Mult_ifc;
    method Action start(Tin x, Tin y);
    method Tout result();
endinterface: Mult_ifc

module mkMult1(Mult_ifc);
    Reg#(Tout) product  <- mkReg(0);
    Reg#(Tout) d        <- mkReg(0);
    Reg#(Tin) r         <- mkReg(0);

    rule cycle(r != 0)
        if(r[0] == 1)
            product <= product + d;
        d <= d << 1;
        r <= r >> 1;
    endrule: cycle

    method Action start(x, y) if (r == 0);
        d <= x;
        r <= y;
    endmethod: start

    method result() if(r == 0);
        return product;
    endmethod: result

//    rule rl_print_answer;
//       $display ("Deep Thought says: Hello, World! The answer is 42.");
//       $finish;
//    endrule
endmodule: mkMult1