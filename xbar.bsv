interface XBar #(type t);
    interface List#(Put#(t)) input_ports;
    interface List#(Get#(t)) output_ports;
endinterface: XBar

module mkXBar#( Integer logn,
                function Bit#(32) destinationOf(t x),
                module #(Merge2x1#(t) mkMerge2x1));

    if(logn == 0)
        FIFO#(t) f <- mkFIFO;
        ...
    else
        XBar(t) upper <- mkXBar(logn - 1, ...)
        XBar(t) lower <- mkXBar(logn - 1, ...)
        ...
        for(Integer j = 0; j < n; j = j + 1) ...
            rule route;
                if(!flip)   merges [j]          .iport0.put(x);
                else        merges [jFlipped]   .iport1.put(x);
            endrule: route

endmodule: mkXBar