module mkTest();
    Reg#(int) state <- mkReg(0);
    Mult_ifc m      <- mkMult1();

    rule go(state == 0);
        m.start(9, 5);
        state <= 1;
    endrule: go

    rule finish(state == 1);
        $display("Product = %d", m.result())
        state <= 2;
    endrule: finish
//    rule rl_print_answer;
//       $display ("Deep Thought says: Hello, World! The answer is 42.");
//       $finish;
//    endrule
endmodule: mkTest