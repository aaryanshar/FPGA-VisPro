module ReadHex;
  reg [7:0] RAM [0:3000]; // Increase the depth of your RAM
  integer i;
  reg clk = 0; // Clock signal

  always begin
    #5 clk = ~clk; // Create a clock signal with a period of 10 time units
  end

  // Your other logic or functionality can go here

  initial begin
    // Initialize RAM with zeros
    for (i = 0; i < 3001; i = i + 1)
      RAM[i] = 8'h00;

    // Read data from the memory file
    $readmemh("sample_imge.hex", RAM); // Correct the filename

    // Display the contents of RAM (for demonstration purposes)
    for (i = 0; i < 3001; i = i + 1)
      $display("RAM[%d]=%h", i, RAM[i]);

    // Optionally, you can add a simulation stop statement here
    $finish;
  end
endmodule
