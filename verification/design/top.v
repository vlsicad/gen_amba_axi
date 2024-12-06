//------------------------------------------------------------------------------
// top.v generated by "gen_ahb_top.sh"
//------------------------------------------------------------------------------
`timescale 1ns/1ns
`ifndef CLK_FREQ
`define CLK_FREQ       50000000
`endif
`ifdef __ICARUS__
`define BUS_DELAY
`else
`ifndef BUS_DELAY
`define BUS_DELAY #(1)
`endif
`endif
`ifndef MEM_DELAY
`define MEM_DELAY 0
`endif
`ifndef SIZE_IN_BYTES_PER_SLAVE
`define SIZE_IN_BYTES_PER_SLAVE (4*1024*1024)
`endif
`ifndef SIZE_IN_BYTES_PER_MASTER
`define SIZE_IN_BYTES_PER_MASTER (((4*1024*1024)*2)/3)
`endif
`ifndef WIDTH_AD
`define WIDTH_AD  32
`endif
`ifndef WIDTH_DA
`define WIDTH_DA  32
`endif
`define AMBA_AXI4
module top;
   //---------------------------------------------------------------------------
   localparam NUM_MST=3
            , NUM_SLV=2;
   localparam WIDTH_CID   = $clog2(NUM_MST) // Channel ID width in bits
            , WIDTH_ID    = 4    // ID width in bits
            , WIDTH_AD    =`WIDTH_AD    // address width
            , WIDTH_DA    =`WIDTH_DA    // data width
            , WIDTH_DS    =(WIDTH_DA/8)  // data strobe width
            , WIDTH_SID   =WIDTH_CID+WIDTH_ID // ID for slave
            `ifdef AMBA_AXI_AWUSER
            , WIDTH_AWUSER=0  // Write-address user path
            `endif
            `ifdef AMBA_AXI_WUSER
            , WIDTH_WUSER =0  // Write-data user path
            `endif
            `ifdef AMBA_AXI_BUSER
            , WIDTH_BUSER =0  // Write-response user path
            `endif
            `ifdef AMBA_AXI_ARUSER
            , WIDTH_ARUSER=0  // read-address user path
            `endif
            `ifdef AMBA_AXI_RUSER
            , WIDTH_RUSER =0  // read-data user path
            `endif
            ;
   //---------------------------------------------------------------------------
   localparam [WIDTH_AD-1:0] ADDR_BASE0='h0; // address base for memory
   localparam [WIDTH_AD-1:0] ADDR_BASE1='h400000; // address base for memory
   localparam ADDR_LENGTH=$clog2('h400000); // address length for each memory
   //---------------------------------------------------------------------------
   localparam CLK_PERIOD_HALF=1_000_000_000/(`CLK_FREQ*2);
   reg         ACLK   = 1'b0; always #(CLK_PERIOD_HALF) ACLK=~ACLK;
   reg         ARESETn= 1'b0; initial #155 ARESETn=1'b1;
   //---------------------------------------------------------------------------
   wire  [WIDTH_ID-1:0]     `BUS_DELAY M_AWID       [0:NUM_MST-1];
   wire  [WIDTH_AD-1:0]     `BUS_DELAY M_AWADDR     [0:NUM_MST-1];
   `ifdef AMBA_AXI4
   wire  [ 7:0]             `BUS_DELAY M_AWLEN      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_AWLOCK     [0:NUM_MST-1];
   `else
   wire  [ 3:0]             `BUS_DELAY M_AWLEN      [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_AWLOCK     [0:NUM_MST-1];
   `endif
   wire  [ 2:0]             `BUS_DELAY M_AWSIZE     [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_AWBURST    [0:NUM_MST-1];
   `ifdef AMBA_AXI_CACHE
   wire  [ 3:0]             `BUS_DELAY M_AWCACHE    [0:NUM_MST-1];
   `endif
   `ifdef AMBA_AXI_PROT
   wire  [ 2:0]             `BUS_DELAY M_AWPROT     [0:NUM_MST-1];
   `endif
   wire                     `BUS_DELAY M_AWVALID    [0:NUM_MST-1];
   wire                     `BUS_DELAY M_AWREADY    [0:NUM_MST-1];
   `ifdef AMBA_QOS
   wire  [ 3:0]             `BUS_DELAY M_AWQOS      [0:NUM_MST-1];
   wire  [ 3:0]             `BUS_DELAY M_AWREGION   [0:NUM_MST-1];
   `endif
   `ifdef AMBA_AXI_AWUSER
   wire  [WIDTH_AWUSER-1:0] `BUS_DELAY M_AWUSER     [0:NUM_MST-1];
   `endif
   wire  [WIDTH_DA-1:0]     `BUS_DELAY M_WDATA      [0:NUM_MST-1];
   wire  [WIDTH_DS-1:0]     `BUS_DELAY M_WSTRB      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_WLAST      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_WVALID     [0:NUM_MST-1];
   wire                     `BUS_DELAY M_WREADY     [0:NUM_MST-1];
   `ifdef AMBA_AXI_WUSER
   wire  [WIDTH_WUSER-1:0]  `BUS_DELAY M_WUSER      [0:NUM_MST-1];
   `endif
   wire  [WIDTH_ID-1:0]     `BUS_DELAY M_BID        [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_BRESP      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_BVALID     [0:NUM_MST-1];
   wire                     `BUS_DELAY M_BREADY     [0:NUM_MST-1];
   `ifdef AMBA_AXI_BUSER
   wire  [WIDTH_BUSER-1:0]  `BUS_DELAY M_BUSER      [0:NUM_MST-1];
   `endif
   wire  [WIDTH_ID-1:0]     `BUS_DELAY M_ARID       [0:NUM_MST-1];
   wire  [WIDTH_AD-1:0]     `BUS_DELAY M_ARADDR     [0:NUM_MST-1];
   `ifdef AMBA_AXI4
   wire  [ 7:0]             `BUS_DELAY M_ARLEN      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_ARLOCK     [0:NUM_MST-1];
   `else
   wire  [ 3:0]             `BUS_DELAY M_ARLEN      [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_ARLOCK     [0:NUM_MST-1];
   `endif
   wire  [ 2:0]             `BUS_DELAY M_ARSIZE     [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_ARBURST    [0:NUM_MST-1];
   `ifdef AMBA_AXI_CACHE
   wire  [ 3:0]             `BUS_DELAY M_ARCACHE    [0:NUM_MST-1];
   `endif
   `ifdef AMBA_AXI_PROT
   wire  [ 2:0]             `BUS_DELAY M_ARPROT     [0:NUM_MST-1];
   `endif
   wire                     `BUS_DELAY M_ARVALID    [0:NUM_MST-1];
   wire                     `BUS_DELAY M_ARREADY    [0:NUM_MST-1];
   `ifdef AMBA_QOS
   wire  [ 3:0]             `BUS_DELAY M_ARQOS      [0:NUM_MST-1];
   wire  [ 3:0]             `BUS_DELAY M_ARREGION   [0:NUM_MST-1];
   `endif
   `ifdef AMBA_AXI_ARUSER
   wire  [WIDTH_ARUSER-1:0] `BUS_DELAY M_ARUSER     [0:NUM_MST-1];
   `endif
   wire  [WIDTH_ID-1:0]     `BUS_DELAY M_RID        [0:NUM_MST-1];
   wire  [WIDTH_DA-1:0]     `BUS_DELAY M_RDATA      [0:NUM_MST-1];
   wire  [ 1:0]             `BUS_DELAY M_RRESP      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_RLAST      [0:NUM_MST-1];
   wire                     `BUS_DELAY M_RVALID     [0:NUM_MST-1];
   wire                     `BUS_DELAY M_RREADY     [0:NUM_MST-1];
   `ifdef AMBA_AXI_RUSER
   wire  [WIDTH_RUSER-1:0]  `BUS_DELAY M_RUSER      [0:NUM_MST-1];
   `endif
   wire                     `BUS_DELAY M_CSYSREQ    [0:NUM_MST-1];
   wire                     `BUS_DELAY M_CSYSACK    [0:NUM_MST-1];
   wire                     `BUS_DELAY M_CACTIVE    [0:NUM_MST-1];
   //------------------------------------------------------------------------
   wire  [WIDTH_SID-1:0]    `BUS_DELAY S_AWID       [0:NUM_SLV-1];
   wire  [WIDTH_AD-1:0]     `BUS_DELAY S_AWADDR     [0:NUM_SLV-1];
   `ifdef AMBA_AXI4
   wire  [ 7:0]             `BUS_DELAY S_AWLEN      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_AWLOCK     [0:NUM_SLV-1];
   `else
   wire  [ 3:0]             `BUS_DELAY S_AWLEN      [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_AWLOCK     [0:NUM_SLV-1];
   `endif
   wire  [ 2:0]             `BUS_DELAY S_AWSIZE     [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_AWBURST    [0:NUM_SLV-1];
   `ifdef AMBA_AXI_CACHE
   wire  [ 3:0]             `BUS_DELAY S_AWCACHE    [0:NUM_SLV-1];
   `endif
   `ifdef AMBA_AXI_PROT
   wire  [ 2:0]             `BUS_DELAY S_AWPROT     [0:NUM_SLV-1];
   `endif
   wire                     `BUS_DELAY S_AWVALID    [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_AWREADY    [0:NUM_SLV-1];
   `ifdef AMBA_QOS
   wire  [ 3:0]             `BUS_DELAY S_AWQOS      [0:NUM_SLV-1];
   wire  [ 3:0]             `BUS_DELAY S_AWREGION   [0:NUM_SLV-1];
   `endif
   `ifdef AMBA_AXI_AWUSER
   wire  [WIDTH_AWUSER-1:0] `BUS_DELAY S_AWUSER     [0:NUM_SLV-1];
   `endif
   wire  [WIDTH_DA-1:0]     `BUS_DELAY S_WDATA      [0:NUM_SLV-1];
   wire  [WIDTH_DS-1:0]     `BUS_DELAY S_WSTRB      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_WLAST      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_WVALID     [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_WREADY     [0:NUM_SLV-1];
   `ifdef AMBA_AXI_WUSER
   wire  [WIDTH_WUSER-1:0]  `BUS_DELAY S_WUSER      [0:NUM_SLV-1];
   `endif
   wire  [WIDTH_SID-1:0]    `BUS_DELAY S_BID        [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_BRESP      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_BVALID     [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_BREADY     [0:NUM_SLV-1];
   `ifdef AMBA_AXI_BUSER
   wire  [WIDTH_BUSER-1:0]  `BUS_DELAY S_BUSER      [0:NUM_SLV-1];
   `endif
   wire  [WIDTH_SID-1:0]    `BUS_DELAY S_ARID       [0:NUM_SLV-1];
   wire  [WIDTH_AD-1:0]     `BUS_DELAY S_ARADDR     [0:NUM_SLV-1];
   `ifdef AMBA_AXI4
   wire  [ 7:0]             `BUS_DELAY S_ARLEN      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_ARLOCK     [0:NUM_SLV-1];
   `else
   wire  [ 3:0]             `BUS_DELAY S_ARLEN      [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_ARLOCK     [0:NUM_SLV-1];
   `endif
   wire  [ 2:0]             `BUS_DELAY S_ARSIZE     [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_ARBURST    [0:NUM_SLV-1];
   `ifdef AMBA_AXI_CACHE
   wire  [ 3:0]             `BUS_DELAY S_ARCACHE    [0:NUM_SLV-1];
   `endif
   `ifdef AMBA_AXI_PROT
   wire  [ 2:0]             `BUS_DELAY S_ARPROT     [0:NUM_SLV-1];
   `endif
   wire                     `BUS_DELAY S_ARVALID    [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_ARREADY    [0:NUM_SLV-1];
   `ifdef AMBA_QOS
   wire  [ 3:0]             `BUS_DELAY S_ARQOS      [0:NUM_SLV-1];
   wire  [ 3:0]             `BUS_DELAY S_ARREGION   [0:NUM_SLV-1];
   `endif
   `ifdef AMBA_AXI_ARUSER
   wire  [WIDTH_ARUSER-1:0] `BUS_DELAY S_ARUSER     [0:NUM_SLV-1];
   `endif
   wire  [WIDTH_SID-1:0]    `BUS_DELAY S_RID        [0:NUM_SLV-1];
   wire  [WIDTH_DA-1:0]     `BUS_DELAY S_RDATA      [0:NUM_SLV-1];
   wire  [ 1:0]             `BUS_DELAY S_RRESP      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_RLAST      [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_RVALID     [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_RREADY     [0:NUM_SLV-1];
   `ifdef AMBA_AXI_RUSER
   wire  [WIDTH_RUSER-1:0]  `BUS_DELAY S_RUSER      [0:NUM_SLV-1];
   `endif
   wire                     `BUS_DELAY S_CSYSREQ    [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_CSYSACK    [0:NUM_SLV-1];
   wire                     `BUS_DELAY S_CACTIVE    [0:NUM_SLV-1];
   //---------------------------------------------------------------------------
   amba_axi_m3s2 #(.NUM_MASTER  (3)
                ,.NUM_SLAVE   (2)
                ,.WIDTH_ID    (WIDTH_ID    )
                ,.WIDTH_AD    (WIDTH_AD    )
                ,.WIDTH_DA    (WIDTH_DA    )
                ,.WIDTH_DS    (WIDTH_DS    )
                `ifdef AMBA_AWUSER
                ,.WIDTH_AWUSER(WIDTH_AWUSER)
                `endif
                `ifdef AMBA_WUSER
                ,.WIDTH_WUSER (WIDTH_WUSER )
                `endif
                `ifdef AMBA_BUSER
                ,.WIDTH_BUSER (WIDTH_BUSER )
                `endif
                `ifdef AMBA_ARUSER
                ,.WIDTH_ARUSER(WIDTH_ARUSER)
                `endif
                `ifdef AMBA_RUSER
                ,.WIDTH_RUSER (WIDTH_RUSER )
                `endif
                ,.ADDR_BASE0  (ADDR_BASE0), .ADDR_LENGTH0(ADDR_LENGTH)
                ,.ADDR_BASE1  (ADDR_BASE1), .ADDR_LENGTH1(ADDR_LENGTH)
                )
   u_amba_axi  (
          .ARESETn      (ARESETn     )
        , .ACLK         (ACLK        )
        , .M0_AWID              (M_AWID    [0])
        , .M0_AWADDR            (M_AWADDR  [0])
        , .M0_AWLEN             (M_AWLEN   [0])
        , .M0_AWLOCK            (M_AWLOCK  [0])
        , .M0_AWSIZE            (M_AWSIZE  [0])
        , .M0_AWBURST           (M_AWBURST [0])
        `ifdef AMBA_AXI_CACHE
        , .M0_AWCACHE           (M_AWCACHE [0])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M0_AWPROT            (M_AWPROT  [0])
        `endif
        , .M0_AWVALID           (M_AWVALID [0])
        , .M0_AWREADY           (M_AWREADY [0])
        `ifdef AMBA_QOS
        , .M0_AWQOS             (M_AWQOS   [0])
        , .M0_AWREGION          (M_AWREGION[0])
        `endif
        `ifdef AMBA_AXI_AWUSER
        , .M0_AWUSER            (M_AWUSER  [0])
        `endif
        , .M0_WDATA             (M_WDATA   [0])
        , .M0_WSTRB             (M_WSTRB   [0])
        , .M0_WLAST             (M_WLAST   [0])
        , .M0_WVALID            (M_WVALID  [0])
        , .M0_WREADY            (M_WREADY  [0])
        `ifdef AMBA_AXI_WUSER
        , .M0_WUSER             (M_WUSER   [0])
        `endif
        , .M0_BID               (M_BID     [0])
        , .M0_BRESP             (M_BRESP   [0])
        , .M0_BVALID            (M_BVALID  [0])
        , .M0_BREADY            (M_BREADY  [0])
        `ifdef AMBA_AXI_BUSER
        , .M0_BUSER             (M_BUSER   [0])
        `endif
        , .M0_ARID              (M_ARID    [0])
        , .M0_ARADDR            (M_ARADDR  [0])
        , .M0_ARLEN             (M_ARLEN   [0])
        , .M0_ARLOCK            (M_ARLOCK  [0])
        , .M0_ARSIZE            (M_ARSIZE  [0])
        , .M0_ARBURST           (M_ARBURST [0])
        `ifdef AMBA_AXI_CACHE
        , .M0_ARCACHE           (M_ARCACHE [0])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M0_ARPROT            (M_ARPROT  [0])
        `endif
        , .M0_ARVALID           (M_ARVALID [0])
        , .M0_ARREADY           (M_ARREADY [0])
        `ifdef AMBA_QOS
        , .M0_ARQOS             (M_ARQOS   [0])
        , .M0_ARREGION          (M_ARREGION[0])
        `endif
        `ifdef AMBA_AXI_ARUSER
        , .M0_ARUSER            (M_ARUSER  [0])
        `endif
        , .M0_RID               (M_RID     [0])
        , .M0_RDATA             (M_RDATA   [0])
        , .M0_RRESP             (M_RRESP   [0])
        , .M0_RLAST             (M_RLAST   [0])
        , .M0_RVALID            (M_RVALID  [0])
        , .M0_RREADY            (M_RREADY  [0])
        `ifdef AMBA_AXI_RUSER
        , .M0_RUSER             (M_RUSER   [0])
        `endif
        , .M1_AWID              (M_AWID    [1])
        , .M1_AWADDR            (M_AWADDR  [1])
        , .M1_AWLEN             (M_AWLEN   [1])
        , .M1_AWLOCK            (M_AWLOCK  [1])
        , .M1_AWSIZE            (M_AWSIZE  [1])
        , .M1_AWBURST           (M_AWBURST [1])
        `ifdef AMBA_AXI_CACHE
        , .M1_AWCACHE           (M_AWCACHE [1])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M1_AWPROT            (M_AWPROT  [1])
        `endif
        , .M1_AWVALID           (M_AWVALID [1])
        , .M1_AWREADY           (M_AWREADY [1])
        `ifdef AMBA_QOS
        , .M1_AWQOS             (M_AWQOS   [1])
        , .M1_AWREGION          (M_AWREGION[1])
        `endif
        `ifdef AMBA_AXI_AWUSER
        , .M1_AWUSER            (M_AWUSER  [1])
        `endif
        , .M1_WDATA             (M_WDATA   [1])
        , .M1_WSTRB             (M_WSTRB   [1])
        , .M1_WLAST             (M_WLAST   [1])
        , .M1_WVALID            (M_WVALID  [1])
        , .M1_WREADY            (M_WREADY  [1])
        `ifdef AMBA_AXI_WUSER
        , .M1_WUSER             (M_WUSER   [1])
        `endif
        , .M1_BID               (M_BID     [1])
        , .M1_BRESP             (M_BRESP   [1])
        , .M1_BVALID            (M_BVALID  [1])
        , .M1_BREADY            (M_BREADY  [1])
        `ifdef AMBA_AXI_BUSER
        , .M1_BUSER             (M_BUSER   [1])
        `endif
        , .M1_ARID              (M_ARID    [1])
        , .M1_ARADDR            (M_ARADDR  [1])
        , .M1_ARLEN             (M_ARLEN   [1])
        , .M1_ARLOCK            (M_ARLOCK  [1])
        , .M1_ARSIZE            (M_ARSIZE  [1])
        , .M1_ARBURST           (M_ARBURST [1])
        `ifdef AMBA_AXI_CACHE
        , .M1_ARCACHE           (M_ARCACHE [1])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M1_ARPROT            (M_ARPROT  [1])
        `endif
        , .M1_ARVALID           (M_ARVALID [1])
        , .M1_ARREADY           (M_ARREADY [1])
        `ifdef AMBA_QOS
        , .M1_ARQOS             (M_ARQOS   [1])
        , .M1_ARREGION          (M_ARREGION[1])
        `endif
        `ifdef AMBA_AXI_ARUSER
        , .M1_ARUSER            (M_ARUSER  [1])
        `endif
        , .M1_RID               (M_RID     [1])
        , .M1_RDATA             (M_RDATA   [1])
        , .M1_RRESP             (M_RRESP   [1])
        , .M1_RLAST             (M_RLAST   [1])
        , .M1_RVALID            (M_RVALID  [1])
        , .M1_RREADY            (M_RREADY  [1])
        `ifdef AMBA_AXI_RUSER
        , .M1_RUSER             (M_RUSER   [1])
        `endif
        , .M2_AWID              (M_AWID    [2])
        , .M2_AWADDR            (M_AWADDR  [2])
        , .M2_AWLEN             (M_AWLEN   [2])
        , .M2_AWLOCK            (M_AWLOCK  [2])
        , .M2_AWSIZE            (M_AWSIZE  [2])
        , .M2_AWBURST           (M_AWBURST [2])
        `ifdef AMBA_AXI_CACHE
        , .M2_AWCACHE           (M_AWCACHE [2])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M2_AWPROT            (M_AWPROT  [2])
        `endif
        , .M2_AWVALID           (M_AWVALID [2])
        , .M2_AWREADY           (M_AWREADY [2])
        `ifdef AMBA_QOS
        , .M2_AWQOS             (M_AWQOS   [2])
        , .M2_AWREGION          (M_AWREGION[2])
        `endif
        `ifdef AMBA_AXI_AWUSER
        , .M2_AWUSER            (M_AWUSER  [2])
        `endif
        , .M2_WDATA             (M_WDATA   [2])
        , .M2_WSTRB             (M_WSTRB   [2])
        , .M2_WLAST             (M_WLAST   [2])
        , .M2_WVALID            (M_WVALID  [2])
        , .M2_WREADY            (M_WREADY  [2])
        `ifdef AMBA_AXI_WUSER
        , .M2_WUSER             (M_WUSER   [2])
        `endif
        , .M2_BID               (M_BID     [2])
        , .M2_BRESP             (M_BRESP   [2])
        , .M2_BVALID            (M_BVALID  [2])
        , .M2_BREADY            (M_BREADY  [2])
        `ifdef AMBA_AXI_BUSER
        , .M2_BUSER             (M_BUSER   [2])
        `endif
        , .M2_ARID              (M_ARID    [2])
        , .M2_ARADDR            (M_ARADDR  [2])
        , .M2_ARLEN             (M_ARLEN   [2])
        , .M2_ARLOCK            (M_ARLOCK  [2])
        , .M2_ARSIZE            (M_ARSIZE  [2])
        , .M2_ARBURST           (M_ARBURST [2])
        `ifdef AMBA_AXI_CACHE
        , .M2_ARCACHE           (M_ARCACHE [2])
        `endif
        `ifdef AMBA_AXI_PROT
        , .M2_ARPROT            (M_ARPROT  [2])
        `endif
        , .M2_ARVALID           (M_ARVALID [2])
        , .M2_ARREADY           (M_ARREADY [2])
        `ifdef AMBA_QOS
        , .M2_ARQOS             (M_ARQOS   [2])
        , .M2_ARREGION          (M_ARREGION[2])
        `endif
        `ifdef AMBA_AXI_ARUSER
        , .M2_ARUSER            (M_ARUSER  [2])
        `endif
        , .M2_RID               (M_RID     [2])
        , .M2_RDATA             (M_RDATA   [2])
        , .M2_RRESP             (M_RRESP   [2])
        , .M2_RLAST             (M_RLAST   [2])
        , .M2_RVALID            (M_RVALID  [2])
        , .M2_RREADY            (M_RREADY  [2])
        `ifdef AMBA_AXI_RUSER
        , .M2_RUSER             (M_RUSER   [2])
        `endif
         , .S0_AWID              (S_AWID    [0])
         , .S0_AWADDR            (S_AWADDR  [0])
         , .S0_AWLEN             (S_AWLEN   [0])
         , .S0_AWLOCK            (S_AWLOCK  [0])
         , .S0_AWSIZE            (S_AWSIZE  [0])
         , .S0_AWBURST           (S_AWBURST [0])
         `ifdef AMBA_AXI_CACHE
         , .S0_AWCACHE           (S_AWCACHE [0])
         `endif
         `ifdef AMBA_AXI_PROT
         , .S0_AWPROT            (S_AWPROT  [0])
         `endif
         , .S0_AWVALID           (S_AWVALID [0])
         , .S0_AWREADY           (S_AWREADY [0])
         `ifdef AMBA_QOS
         , .S0_AWQOS             (S_AWQOS   [0])
         , .S0_AWREGION          (S_AWREGION[0])
         `endif
         `ifdef AMBA_AXI_AWUSER
         , .S0_AWUSER            (S_AWUSER  [0])
         `endif
         , .S0_WDATA             (S_WDATA   [0])
         , .S0_WSTRB             (S_WSTRB   [0])
         , .S0_WLAST             (S_WLAST   [0])
         , .S0_WVALID            (S_WVALID  [0])
         , .S0_WREADY            (S_WREADY  [0])
         `ifdef AMBA_AXI_WUSER
         , .S0_WUSER             (S_WUSER   [0])
         `endif
         , .S0_BID               (S_BID     [0])
         , .S0_BRESP             (S_BRESP   [0])
         , .S0_BVALID            (S_BVALID  [0])
         , .S0_BREADY            (S_BREADY  [0])
         `ifdef AMBA_AXI_BUSER
         , .S0_BUSER             (S_BUSER   [0])
         `endif
         , .S0_ARID              (S_ARID    [0])
         , .S0_ARADDR            (S_ARADDR  [0])
         , .S0_ARLEN             (S_ARLEN   [0])
         , .S0_ARLOCK            (S_ARLOCK  [0])
         , .S0_ARSIZE            (S_ARSIZE  [0])
         , .S0_ARBURST           (S_ARBURST [0])
         `ifdef AMBA_AXI_CACHE
         , .S0_ARCACHE           (S_ARCACHE [0])
         `endif
         `ifdef AMBA_AXI_PROT
         , .S0_ARPROT            (S_ARPROT  [0])
         `endif
         , .S0_ARVALID           (S_ARVALID [0])
         , .S0_ARREADY           (S_ARREADY [0])
         `ifdef AMBA_QOS
         , .S0_ARQOS             (S_ARQOS   [0])
         , .S0_ARREGION          (S_ARREGION[0])
         `endif
         `ifdef AMBA_AXI_ARUSER
         , .S0_ARUSER            (S_ARUSER  [0])
         `endif
         , .S0_RID               (S_RID     [0])
         , .S0_RDATA             (S_RDATA   [0])
         , .S0_RRESP             (S_RRESP   [0])
         , .S0_RLAST             (S_RLAST   [0])
         , .S0_RVALID            (S_RVALID  [0])
         , .S0_RREADY            (S_RREADY  [0])
         `ifdef AMBA_AXI_RUSER
         , .S0_RUSER             (S_RUSER   [0])
         `endif
         , .S1_AWID              (S_AWID    [1])
         , .S1_AWADDR            (S_AWADDR  [1])
         , .S1_AWLEN             (S_AWLEN   [1])
         , .S1_AWLOCK            (S_AWLOCK  [1])
         , .S1_AWSIZE            (S_AWSIZE  [1])
         , .S1_AWBURST           (S_AWBURST [1])
         `ifdef AMBA_AXI_CACHE
         , .S1_AWCACHE           (S_AWCACHE [1])
         `endif
         `ifdef AMBA_AXI_PROT
         , .S1_AWPROT            (S_AWPROT  [1])
         `endif
         , .S1_AWVALID           (S_AWVALID [1])
         , .S1_AWREADY           (S_AWREADY [1])
         `ifdef AMBA_QOS
         , .S1_AWQOS             (S_AWQOS   [1])
         , .S1_AWREGION          (S_AWREGION[1])
         `endif
         `ifdef AMBA_AXI_AWUSER
         , .S1_AWUSER            (S_AWUSER  [1])
         `endif
         , .S1_WDATA             (S_WDATA   [1])
         , .S1_WSTRB             (S_WSTRB   [1])
         , .S1_WLAST             (S_WLAST   [1])
         , .S1_WVALID            (S_WVALID  [1])
         , .S1_WREADY            (S_WREADY  [1])
         `ifdef AMBA_AXI_WUSER
         , .S1_WUSER             (S_WUSER   [1])
         `endif
         , .S1_BID               (S_BID     [1])
         , .S1_BRESP             (S_BRESP   [1])
         , .S1_BVALID            (S_BVALID  [1])
         , .S1_BREADY            (S_BREADY  [1])
         `ifdef AMBA_AXI_BUSER
         , .S1_BUSER             (S_BUSER   [1])
         `endif
         , .S1_ARID              (S_ARID    [1])
         , .S1_ARADDR            (S_ARADDR  [1])
         , .S1_ARLEN             (S_ARLEN   [1])
         , .S1_ARLOCK            (S_ARLOCK  [1])
         , .S1_ARSIZE            (S_ARSIZE  [1])
         , .S1_ARBURST           (S_ARBURST [1])
         `ifdef AMBA_AXI_CACHE
         , .S1_ARCACHE           (S_ARCACHE [1])
         `endif
         `ifdef AMBA_AXI_PROT
         , .S1_ARPROT            (S_ARPROT  [1])
         `endif
         , .S1_ARVALID           (S_ARVALID [1])
         , .S1_ARREADY           (S_ARREADY [1])
         `ifdef AMBA_QOS
         , .S1_ARQOS             (S_ARQOS   [1])
         , .S1_ARREGION          (S_ARREGION[1])
         `endif
         `ifdef AMBA_AXI_ARUSER
         , .S1_ARUSER            (S_ARUSER  [1])
         `endif
         , .S1_RID               (S_RID     [1])
         , .S1_RDATA             (S_RDATA   [1])
         , .S1_RRESP             (S_RRESP   [1])
         , .S1_RLAST             (S_RLAST   [1])
         , .S1_RVALID            (S_RVALID  [1])
         , .S1_RREADY            (S_RREADY  [1])
         `ifdef AMBA_AXI_RUSER
         , .S1_RUSER             (S_RUSER   [1])
         `endif
   );
   //---------------------------------------------------------------------------
   wire [NUM_MST-1:0]      done;
   wire [NUM_MST-1:0]      busy_out;
   wire               #(1) busy_in=|busy_out;
   //---------------------------------------------------------------------------
   generate
   genvar idx;
   for (idx=0; idx<NUM_MST; idx=idx+1) begin : BLK_MST
        axi_tester #(.P_MST_ID(idx)
                    ,.P_NUM_MST(NUM_MST)
                    ,.P_NUM_SLV(NUM_SLV)
                    ,.P_SIZE_IN_BYTES(`SIZE_IN_BYTES_PER_MASTER)
                    ,.WIDTH_CID(WIDTH_CID)
                    ,.WIDTH_ID (WIDTH_ID ) // ID width in bits
                    ,.WIDTH_AD (WIDTH_AD ) // address width
                    ,.WIDTH_DA (WIDTH_DA ))// data width
        u_tester (
              .ARESETn   (ARESETn      )
            , .ACLK      (ACLK         )
            , .AWID      (M_AWID    [idx])
            , .AWADDR    (M_AWADDR  [idx])
            , .AWLEN     (M_AWLEN   [idx])
            , .AWLOCK    (M_AWLOCK  [idx])
            , .AWSIZE    (M_AWSIZE  [idx])
            , .AWBURST   (M_AWBURST [idx])
            `ifdef AMBA_AXI_CACHE
            , .AWCACHE   (M_AWCACHE [idx])
            `endif
            `ifdef AMBA_AXI_PROT
            , .AWPROT    (M_AWPROT  [idx])
            `endif
            , .AWVALID   (M_AWVALID [idx])
            , .AWREADY   (M_AWREADY [idx])
            `ifdef AMBA_QOS
            , .AWQOS     (M_AWQOS   [idx])
            , .AWREGION  (M_AWREGION[idx])
            `endif
            , .WDATA     (M_WDATA   [idx])
            , .WSTRB     (M_WSTRB   [idx])
            , .WLAST     (M_WLAST   [idx])
            , .WVALID    (M_WVALID  [idx])
            , .WREADY    (M_WREADY  [idx])
            , .BID       (M_BID     [idx])
            , .BRESP     (M_BRESP   [idx])
            , .BVALID    (M_BVALID  [idx])
            , .BREADY    (M_BREADY  [idx])
            , .ARID      (M_ARID    [idx])
            , .ARADDR    (M_ARADDR  [idx])
            , .ARLEN     (M_ARLEN   [idx])
            , .ARLOCK    (M_ARLOCK  [idx])
            , .ARSIZE    (M_ARSIZE  [idx])
            , .ARBURST   (M_ARBURST [idx])
            `ifdef AMBA_AXI_CACHE
            , .ARCACHE   (M_ARCACHE [idx])
            `endif
            `ifdef AMBA_AXI_PROT
            , .ARPROT    (M_ARPROT  [idx])
            `endif
            , .ARVALID   (M_ARVALID [idx])
            , .ARREADY   (M_ARREADY [idx])
            `ifdef AMBA_QOS
            , .ARQOS     (M_ARQOS   [idx])
            , .ARREGION  (M_ARREGION[idx])
            `endif
            , .RID       (M_RID     [idx])
            , .RDATA     (M_RDATA   [idx])
            , .RRESP     (M_RRESP   [idx])
            , .RLAST     (M_RLAST   [idx])
            , .RVALID    (M_RVALID  [idx])
            , .RREADY    (M_RREADY  [idx])
            , .CSYSREQ   (M_CSYSREQ [idx])
            , .CSYSACK   (M_CSYSACK [idx])
            , .CACTIVE   (M_CACTIVE [idx])
            , .busy_out(busy_out[idx])
            , .busy_in (busy_in      )
        );
        assign done[idx] = BLK_MST[idx].u_tester.done;
        assign M_CSYSREQ[idx] = 1'b0;
   end // for
   endgenerate
   //---------------------------------------------------------------------------\n
   initial begin
        $display("mem_axi 0 A=0x%08X ~ %08X", ADDR_BASE0, ADDR_BASE0+(1<<ADDR_LENGTH)-1);
        $display("mem_axi 1 A=0x%08X ~ %08X", ADDR_BASE1, ADDR_BASE1+(1<<ADDR_LENGTH)-1);
    end
   //---------------------------------------------------------------------------
   generate
   genvar idy;
   for (idy=0; idy<NUM_SLV; idy=idy+1) begin : BLK_SLV
      //mem_axi #(.P_SLV_ID(idy)
      //         ,.P_SIZE_IN_BYTES(`SIZE_IN_BYTES_PER_SLAVE)
      //         ,.P_DELAY(`MEM_DELAY)
      //         ,.WIDTH_CID  (WIDTH_CID)// Channel ID width in bits
      //         ,.WIDTH_ID   (WIDTH_ID )// ID width in bits
      //         ,.WIDTH_AD   (WIDTH_AD )// address width
      //         ,.WIDTH_DA   (WIDTH_DA )// data width
      //         ,.WIDTH_DS   (WIDTH_DS )// data strobe width
      //         ,.ADDR_LENGTH(ADDR_LENGTH)) // effective addre bits"
        mem_axi #(.AXI_WIDTH_CID  (WIDTH_CID)// Channel ID width in bits
                 ,.AXI_WIDTH_ID   (WIDTH_ID )// ID width in bits
                 ,.AXI_WIDTH_AD   (WIDTH_AD )// address width
                 ,.AXI_WIDTH_DA   (WIDTH_DA )// data width
                 ,.AXI_WIDTH_DS   (WIDTH_DS )// data strobe width
                 ,.SIZE_IN_BYTES  (`SIZE_IN_BYTES_PER_SLAVE)
                 ,.ID             (idy))
        u_mem_axi (
               .ARESETn  (ARESETn         )
             , .ACLK     (ACLK            )
             , .AWID     (S_AWID     [idy])
             , .AWADDR   (S_AWADDR   [idy])
             , .AWLEN    (S_AWLEN    [idy])
             , .AWLOCK   (S_AWLOCK   [idy])
             , .AWSIZE   (S_AWSIZE   [idy])
             , .AWBURST  (S_AWBURST  [idy])
             `ifdef AMBA_AXI_CACHE
             , .AWCACHE  (S_AWCACHE  [idy])
             `endif
             `ifdef AMBA_AXI_PROT
             , .AWPROT   (S_AWPROT   [idy])
             `endif
             , .AWVALID  (S_AWVALID  [idy])
             , .AWREADY  (S_AWREADY  [idy])
             `ifdef AMBA_QOS
             , .AWQOS    (S_AWQOS    [idy])
             , .AWREGION (S_AWREGION [idy])
             `endif
             , .WDATA    (S_WDATA    [idy])
             , .WSTRB    (S_WSTRB    [idy])
             , .WLAST    (S_WLAST    [idy])
             , .WVALID   (S_WVALID   [idy])
             , .WREADY   (S_WREADY   [idy])
             , .BID      (S_BID      [idy])
             , .BRESP    (S_BRESP    [idy])
             , .BVALID   (S_BVALID   [idy])
             , .BREADY   (S_BREADY   [idy])
             , .ARID     (S_ARID     [idy])
             , .ARADDR   (S_ARADDR   [idy])
             , .ARLEN    (S_ARLEN    [idy])
             , .ARLOCK   (S_ARLOCK   [idy])
             , .ARSIZE   (S_ARSIZE   [idy])
             , .ARBURST  (S_ARBURST  [idy])
             `ifdef AMBA_AXI_CACHE
             , .ARCACHE  (S_ARCACHE  [idy])
             `endif
             `ifdef AMBA_AXI_PROT
             , .ARPROT   (S_ARPROT   [idy])
             `endif
             , .ARVALID  (S_ARVALID  [idy])
             , .ARREADY  (S_ARREADY  [idy])
             `ifdef AMBA_QOS 
             , .ARQOS    (S_ARQOS    [idy])
             , .ARREGION (S_ARREGION [idy])
             `endif
             , .RID      (S_RID      [idy])
             , .RDATA    (S_RDATA    [idy])
             , .RRESP    (S_RRESP    [idy])
             , .RLAST    (S_RLAST    [idy])
             , .RVALID   (S_RVALID   [idy])
             , .RREADY   (S_RREADY   [idy])
           //, .CSYSREQ  (S_CSYSREQ  [idy])
             , .CSYSREQ  (&done)
             , .CSYSACK  (S_CSYSACK  [idy])
             , .CACTIVE  (S_CACTIVE  [idy])
        );
        assign  S_CSYSREQ[idy] = 1'b0;
   end // for
   endgenerate
   //---------------------------------------------------------------------------
   integer idz;
   initial begin
       wait(ARESETn==1'b0);
       wait(ARESETn==1'b1);
       for (idz=0; idz<NUM_MST; idz=idz+1) begin
            wait(done[idz]==1'b1);
       end
       //for (idz=0; idz<NUM_SLV; idz=idz+1) begin
       //     BLK_SLV[idz].u_mem_axi.axi_statistics(idz);
       //end
       repeat (5) @ (posedge ACLK);
       $finish(2);
   end
   //---------------------------------------------------------------------------
   initial begin
      `ifdef VCD
          // use +define+VCD in 'vlog'
          $dumpfile("wave.vcd");
          $dumpvars(0);
      `else
           // use +VCD in 'vsim'
           if ($test$plusargs("VCD")) begin
               $dumpfile("wave.vcd");
               $dumpvars(5);
           end
      `endif
   end
   //---------------------------------------------------------------------------
endmodule
