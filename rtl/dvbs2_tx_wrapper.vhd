---------------
-- Libraries --
---------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dvbs2_tx_wrapper_regmap_regs_pkg.all;

------------------------
-- Entity declaration --
------------------------
entity dvbs2_tx_wrapper is
  generic (
    -- AXI streaming widths
    AXIS_DATA_WIDTH : integer := 32
  );
  port (
    -- AXI4 lite
    --Clock and Reset
    s_axi_aclk             : in  std_logic;
    s_axi_aresetn          : in  std_logic;
    --write address channel
    s_axi_awvalid          : in  std_logic;
    s_axi_awready          : out std_logic;
    s_axi_awaddr           : in  std_logic_vector(31 downto 0);
    s_axi_awprot           : in  std_logic_vector(2 downto 0);
    -- write data channel
    s_axi_wvalid           : in  std_logic;
    s_axi_wready           : out std_logic;
    s_axi_wdata            : in  std_logic_vector(31 downto 0);
    s_axi_wstrb            : in  std_logic_vector(3 downto 0);
    --read address channel
    s_axi_arvalid          : in  std_logic;
    s_axi_arready          : out std_logic;
    s_axi_araddr           : in  std_logic_vector(31 downto 0);
    s_axi_arprot           : in  std_logic_vector(2 downto 0);
    --read data channel
    s_axi_rvalid           : out std_logic;
    s_axi_rready           : in  std_logic;
    s_axi_rdata            : out std_logic_vector(31 downto 0);
    s_axi_rresp            : out std_logic_vector(1 downto 0);
    --write response channel
    s_axi_bvalid           : out std_logic;
    s_axi_bready           : in  std_logic;
    s_axi_bresp            : out std_logic_vector(1 downto 0);

    coeffs_axi_aclk        : in  std_logic;
    coeffs_axi_aresetn     : in  std_logic;
    coeffs_axi_awvalid     : in  std_logic;
    coeffs_axi_awready     : out std_logic;
    coeffs_axi_awaddr      : in  std_logic_vector(31 downto 0);
    coeffs_axi_awprot      : in  std_logic_vector(2 downto 0);
    coeffs_axi_wvalid      : in  std_logic;
    coeffs_axi_wready      : out std_logic;
    coeffs_axi_wdata       : in  std_logic_vector(31 downto 0);
    coeffs_axi_wstrb       : in  std_logic_vector(3 downto 0);
    coeffs_axi_bvalid      : out std_logic;
    coeffs_axi_bready      : in  std_logic;
    coeffs_axi_bresp       : out std_logic_vector(1 downto 0);
    coeffs_axi_arvalid     : in  std_logic;
    coeffs_axi_arready     : out std_logic;
    coeffs_axi_araddr      : in  std_logic_vector(31 downto 0);
    coeffs_axi_arprot      : in  std_logic_vector(2 downto 0);
    coeffs_axi_rvalid      : out std_logic;
    coeffs_axi_rready      : in  std_logic;
    coeffs_axi_rdata       : out std_logic_vector(31 downto 0);
    coeffs_axi_rresp       : out std_logic_vector(1 downto 0);
    -- Input data
    s_axis_aclk            : in  std_logic;
    s_axis_aresetn         : in  std_logic;
    s_axis_tvalid          : in  std_logic;
    s_axis_tlast           : in  std_logic;
    s_axis_tready          : out std_logic;
    s_axis_tdata           : in  std_logic_vector(31 downto 0);
    s_axis_tid             : in  std_logic_vector(8 downto 0);
    s_axis_tkeep           : in  std_logic_vector(3 downto 0);
    -- Output data
    m_axis_tvalid          : out std_logic;
    m_axis_tlast           : out std_logic;
    m_axis_tready          : in  std_logic;
    m_axis_tdata           : out std_logic_vector(31 downto 0);
    m_axis_tkeep           : out std_logic_vector(3 downto 0) := (others => '1'));
end dvbs2_tx_wrapper;

architecture rtl of dvbs2_tx_wrapper is

  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO of s_axi_araddr  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite ARADDR";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_arprot  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite ARPROT";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_arready : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite ARREADY";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_arvalid : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite ARVALID";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_awaddr  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite AWADDR";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_awprot  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite AWPROT";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_awready : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite AWREADY";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_awvalid : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite AWVALID";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_bready  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite BREADY";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_bresp   : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite BRESP";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_bvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite BVALID";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_rdata   : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite RDATA";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_rready  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite RREADY";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_rresp   : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite RRESP";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_rvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite RVALID";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_wdata   : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite WDATA";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_wready  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite WREADY";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_wstrb   : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite WSTRB";
  ATTRIBUTE X_INTERFACE_INFO of s_axi_wvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 s_axi_lite WVALID";


  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_aclk    : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ACLK";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_aresetn : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ARESETN";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_araddr  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ARADDR";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_arprot  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ARPROT";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_arready : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ARREADY";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_arvalid : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite ARVALID";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_awaddr  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite AWADDR";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_awprot  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite AWPROT";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_awready : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite AWREADY";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_awvalid : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite AWVALID";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_bready  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite BREADY";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_bresp   : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite BRESP";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_bvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite BVALID";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_rdata   : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite RDATA";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_rready  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite RREADY";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_rresp   : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite RRESP";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_rvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite RVALID";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_wdata   : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite WDATA";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_wready  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite WREADY";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_wstrb   : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite WSTRB";
  ATTRIBUTE X_INTERFACE_INFO of coeffs_axi_wvalid  : SIGNAL is "xilinx.com:interface:aximm:1.0 coeffs_axi_lite WVALID";

  signal rst       : std_logic;

  -- User signals  :
  signal user2regs : user2regs_t;
  signal regs2user : regs2user_t;

begin

  rst <= not s_axi_aresetn;

  regs_u : entity work.dvbs2_tx_wrapper_regmap_regs
      generic map (
          AXI_ADDR_WIDTH => 32,
          BASEADDR       => (others => '0')
      )
      port map(
          -- Clock and Reset
          axi_aclk      => s_axi_aclk,
          axi_aresetn   => s_axi_aresetn,
          -- AXI Write Address Channel
          s_axi_awaddr  => s_axi_awaddr,
          s_axi_awprot  => s_axi_awprot,
          s_axi_awvalid => s_axi_awvalid,
          s_axi_awready => s_axi_awready,
          -- AXI Write Data Channel
          s_axi_wdata   => s_axi_wdata,
          s_axi_wstrb   => s_axi_wstrb,
          s_axi_wvalid  => s_axi_wvalid,
          s_axi_wready  => s_axi_wready,
          -- AXI Read Address Channel
          s_axi_araddr  => s_axi_araddr,
          s_axi_arprot  => s_axi_arprot,
          s_axi_arvalid => s_axi_arvalid,
          s_axi_arready => s_axi_arready,
          -- AXI Read Data Channel
          s_axi_rdata   => s_axi_rdata,
          s_axi_rresp   => s_axi_rresp,
          s_axi_rvalid  => s_axi_rvalid,
          s_axi_rready  => s_axi_rready,
          -- AXI Write Response Channel
          s_axi_bresp   => s_axi_bresp,
          s_axi_bvalid  => s_axi_bvalid,
          s_axi_bready  => s_axi_bready,
          -- User Ports
          user2regs     => user2regs,
          regs2user     => regs2user
      );

  dvbs2_tx_u : entity work.dvbs2_tx
    generic map ( DATA_WIDTH => AXIS_DATA_WIDTH )
    port map (
      -- Usual ports
      clk                     => s_axis_aclk,
      rst                     => s_axis_aresetn,
      -- FIXME: Replace individual status/config, bit mapper RAM and coefficients ports with
      -- a simple UPC interface, preferably non AXI4-MM as it adds a lot of unnecessary
      -- complexity to the testbench
      -- Status and static parameters
      cfg_enable_dummy_frames => regs2user.config_enable_dummy_frames(0),
      cfg_coefficients_rst    => regs2user.config_reset_polyphase_coefficients(0),
      sts_frame_in_transit    => user2regs.frames_in_transit_value,
      sts_ldpc_fifo_entries   => user2regs.ldpc_fifo_status_ldpc_fifo_entries,
      sts_ldpc_fifo_empty     => user2regs.ldpc_fifo_status_ldpc_fifo_empty(0),
      sts_ldpc_fifo_full      => user2regs.ldpc_fifo_status_ldpc_fifo_full(0),
      -- Constellation mapper RAM interface
      bit_mapper_ram_wren     => regs2user.bit_mapper_ram_wen(3) or regs2user.bit_mapper_ram_wen(2) or regs2user.bit_mapper_ram_wen(1) or regs2user.bit_mapper_ram_wen(0),
      bit_mapper_ram_addr     => regs2user.bit_mapper_ram_addr,
      bit_mapper_ram_wdata    => regs2user.bit_mapper_ram_wdata,
      bit_mapper_ram_rdata    => user2regs.bit_mapper_ram_rdata,
      -- Polyphase filter coefficients interface
      coeffs_axi_aclk         => coeffs_axi_aclk,
      coeffs_axi_aresetn      => coeffs_axi_aresetn,
      coeffs_axi_awvalid      => coeffs_axi_awvalid,
      coeffs_axi_awready      => coeffs_axi_awready,
      coeffs_axi_awaddr       => coeffs_axi_awaddr,
      coeffs_axi_awprot       => coeffs_axi_awprot,
      coeffs_axi_wvalid       => coeffs_axi_wvalid,
      coeffs_axi_wready       => coeffs_axi_wready,
      coeffs_axi_wdata        => coeffs_axi_wdata,
      coeffs_axi_wstrb        => coeffs_axi_wstrb,
      coeffs_axi_bvalid       => coeffs_axi_bvalid,
      coeffs_axi_bready       => coeffs_axi_bready,
      coeffs_axi_bresp        => coeffs_axi_bresp,
      coeffs_axi_arvalid      => coeffs_axi_arvalid,
      coeffs_axi_arready      => coeffs_axi_arready,
      coeffs_axi_araddr       => coeffs_axi_araddr,
      coeffs_axi_arprot       => coeffs_axi_arprot,
      coeffs_axi_rvalid       => coeffs_axi_rvalid,
      coeffs_axi_rready       => coeffs_axi_rready,
      coeffs_axi_rdata        => coeffs_axi_rdata,
      coeffs_axi_rresp        => coeffs_axi_rresp,
      -- Per frame config input
      cfg_constellation       => s_axis_tid(2 downto 0),
      cfg_frame_type          => s_axis_tid(4 downto 3),
      cfg_code_rate           => s_axis_tid(8 downto 5),
      -- AXI input
      s_tvalid                => s_axis_tvalid,
      s_tdata                 => s_axis_tdata,
      s_tkeep                 => s_axis_tkeep,
      s_tlast                 => s_axis_tlast,
      s_tready                => s_axis_tready,
      -- AXI output
      m_tready                => m_axis_tready,
      m_tvalid                => m_axis_tvalid,
      m_tlast                 => m_axis_tlast,
      m_tdata                 => m_axis_tdata);
end architecture;
