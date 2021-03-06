-- -----------------------------------------------------------------------------
-- 'dvbs2_tx_wrapper_regmap' Register Component
-- Revision: 16
-- -----------------------------------------------------------------------------
-- Generated on 2021-02-21 at 14:51 (UTC) by airhdl version 2021.02.1
-- -----------------------------------------------------------------------------
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
-- POSSIBILITY OF SUCH DAMAGE.
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dvbs2_tx_wrapper_regmap_regs_pkg.all;

entity dvbs2_tx_wrapper_regmap_regs is
    generic(
        AXI_ADDR_WIDTH : integer := 32;  -- width of the AXI address bus
        BASEADDR : std_logic_vector(31 downto 0) := x"00000000" -- the register file's system base address		
    );
    port(
        -- Clock and Reset
        axi_aclk    : in  std_logic;
        axi_aresetn : in  std_logic;
        -- AXI Write Address Channel
        s_axi_awaddr  : in  std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
        s_axi_awprot  : in  std_logic_vector(2 downto 0); -- sigasi @suppress "Unused port"
        s_axi_awvalid : in  std_logic;
        s_axi_awready : out std_logic;
        -- AXI Write Data Channel
        s_axi_wdata   : in  std_logic_vector(31 downto 0);
        s_axi_wstrb   : in  std_logic_vector(3 downto 0);
        s_axi_wvalid  : in  std_logic;
        s_axi_wready  : out std_logic;
        -- AXI Read Address Channel
        s_axi_araddr  : in  std_logic_vector(AXI_ADDR_WIDTH - 1 downto 0);
        s_axi_arprot  : in  std_logic_vector(2 downto 0); -- sigasi @suppress "Unused port"
        s_axi_arvalid : in  std_logic;
        s_axi_arready : out std_logic;
        -- AXI Read Data Channel
        s_axi_rdata   : out std_logic_vector(31 downto 0);
        s_axi_rresp   : out std_logic_vector(1 downto 0);
        s_axi_rvalid  : out std_logic;
        s_axi_rready  : in  std_logic;
        -- AXI Write Response Channel
        s_axi_bresp   : out std_logic_vector(1 downto 0);
        s_axi_bvalid  : out std_logic;
        s_axi_bready  : in  std_logic;
        -- User Ports
        user2regs     : in user2regs_t;
        regs2user     : out regs2user_t
    );
end entity dvbs2_tx_wrapper_regmap_regs;

architecture RTL of dvbs2_tx_wrapper_regmap_regs is

    -- Constants
    constant AXI_OKAY           : std_logic_vector(1 downto 0) := "00";
    constant AXI_DECERR         : std_logic_vector(1 downto 0) := "11";

    -- Registered signals
    signal s_axi_awready_r    : std_logic;
    signal s_axi_wready_r     : std_logic;
    signal s_axi_awaddr_reg_r : unsigned(s_axi_awaddr'range);
    signal s_axi_bvalid_r     : std_logic;
    signal s_axi_bresp_r      : std_logic_vector(s_axi_bresp'range);
    signal s_axi_arready_r    : std_logic;
    signal s_axi_araddr_reg_r : unsigned(s_axi_araddr'range);
    signal s_axi_rvalid_r     : std_logic;
    signal s_axi_rresp_r      : std_logic_vector(s_axi_rresp'range);
    signal s_axi_wdata_reg_r  : std_logic_vector(s_axi_wdata'range);
    signal s_axi_wstrb_reg_r  : std_logic_vector(s_axi_wstrb'range);
    signal s_axi_rdata_r      : std_logic_vector(s_axi_rdata'range);
    
    -- User-defined registers
    signal s_bit_mapper_ram_raddr_r : std_logic_vector(5 downto 0);
    signal s_bit_mapper_ram_rdata : std_logic_vector(31 downto 0);
    signal s_bit_mapper_ram_waddr_r : std_logic_vector(5 downto 0);
    signal s_bit_mapper_ram_wen_r : std_logic_vector(3 downto 0);
    signal s_bit_mapper_ram_wdata_r : std_logic_vector(31 downto 0);        
    signal s_config_strobe_r : std_logic;
    signal s_reg_config_enable_dummy_frames_r : std_logic_vector(0 downto 0);
    signal s_reg_config_reset_polyphase_coefficients_r : std_logic_vector(0 downto 0);
    signal s_ldpc_fifo_status_strobe_r : std_logic;
    signal s_reg_ldpc_fifo_status_ldpc_fifo_entries : std_logic_vector(13 downto 0);
    signal s_reg_ldpc_fifo_status_ldpc_fifo_empty : std_logic_vector(0 downto 0);
    signal s_reg_ldpc_fifo_status_ldpc_fifo_full : std_logic_vector(0 downto 0);
    signal s_frames_in_transit_strobe_r : std_logic;
    signal s_reg_frames_in_transit_value : std_logic_vector(7 downto 0);

begin

    ----------------------------------------------------------------------------
    -- Inputs
    --
    s_bit_mapper_ram_rdata <= user2regs.bit_mapper_ram_rdata; 
    s_reg_ldpc_fifo_status_ldpc_fifo_entries <= user2regs.ldpc_fifo_status_ldpc_fifo_entries;
    s_reg_ldpc_fifo_status_ldpc_fifo_empty <= user2regs.ldpc_fifo_status_ldpc_fifo_empty;
    s_reg_ldpc_fifo_status_ldpc_fifo_full <= user2regs.ldpc_fifo_status_ldpc_fifo_full;
    s_reg_frames_in_transit_value <= user2regs.frames_in_transit_value;

    ----------------------------------------------------------------------------
    -- Read-transaction FSM
    --    
    read_fsm : process(axi_aclk, axi_aresetn) is
        constant MAX_MEMORY_LATENCY : natural := 3;
        type t_state is (IDLE, READ_REGISTER, WAIT_MEMORY_RDATA, READ_RESPONSE, DONE);
        -- registered state variables
        variable v_state_r          : t_state;
        variable v_rdata_r          : std_logic_vector(31 downto 0);
        variable v_rresp_r          : std_logic_vector(s_axi_rresp'range);
        variable v_mem_wait_count_r : natural range 0 to MAX_MEMORY_LATENCY;
        -- combinatorial helper variables
        variable v_addr_hit : boolean;
        variable v_mem_addr : unsigned(AXI_ADDR_WIDTH-1 downto 0);
    begin
        if axi_aresetn = '0' then
            v_state_r          := IDLE;
            v_rdata_r          := (others => '0');
            v_rresp_r          := (others => '0');
            v_mem_wait_count_r := 0;
            s_axi_arready_r    <= '0';
            s_axi_rvalid_r     <= '0';
            s_axi_rresp_r      <= (others => '0');
            s_axi_araddr_reg_r <= (others => '0');
            s_axi_rdata_r      <= (others => '0');
            s_bit_mapper_ram_raddr_r <= (others => '0');
            s_ldpc_fifo_status_strobe_r <= '0';
            s_frames_in_transit_strobe_r <= '0';
 
        elsif rising_edge(axi_aclk) then
            -- Default values:
            s_axi_arready_r <= '0';
            s_bit_mapper_ram_raddr_r <= (others => '0');
            s_ldpc_fifo_status_strobe_r <= '0';
            s_frames_in_transit_strobe_r <= '0';

            case v_state_r is

                -- Wait for the start of a read transaction, which is 
                -- initiated by the assertion of ARVALID
                when IDLE =>
                    if s_axi_arvalid = '1' then
                        s_axi_araddr_reg_r <= unsigned(s_axi_araddr); -- save the read address
                        s_axi_arready_r    <= '1'; -- acknowledge the read-address
                        v_state_r          := READ_REGISTER;
                    end if;

                -- Read from the actual storage element
                when READ_REGISTER =>
                    -- defaults:
                    v_addr_hit := false;
                    v_rdata_r  := (others => '0');
                    
                    -- memory 'bit_mapper_ram' at address offset 0x0
                    if s_axi_araddr_reg_r >= resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET, AXI_ADDR_WIDTH) and 
                        s_axi_araddr_reg_r < resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET + BIT_MAPPER_RAM_DEPTH * 4, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;
                        -- generate memory read address:
                        v_mem_addr := s_axi_araddr_reg_r - unsigned(BASEADDR) - BIT_MAPPER_RAM_OFFSET;
                        s_bit_mapper_ram_raddr_r <= std_logic_vector(v_mem_addr(7 downto 2)); -- output address has 4-byte granularity
                        v_mem_wait_count_r := BIT_MAPPER_RAM_READ_LATENCY;
                        v_state_r := WAIT_MEMORY_RDATA;
                    end if;
                    -- register 'config' at address offset 0xF0 
                    if s_axi_araddr_reg_r = resize(unsigned(BASEADDR) + CONFIG_OFFSET, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;
                        v_rdata_r(0 downto 0) := s_reg_config_enable_dummy_frames_r;
                        v_rdata_r(1 downto 1) := s_reg_config_reset_polyphase_coefficients_r;
                        v_state_r := READ_RESPONSE;
                    end if;
                    -- register 'ldpc_fifo_status' at address offset 0xF4 
                    if s_axi_araddr_reg_r = resize(unsigned(BASEADDR) + LDPC_FIFO_STATUS_OFFSET, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;
                        v_rdata_r(13 downto 0) := s_reg_ldpc_fifo_status_ldpc_fifo_entries;
                        v_rdata_r(16 downto 16) := s_reg_ldpc_fifo_status_ldpc_fifo_empty;
                        v_rdata_r(17 downto 17) := s_reg_ldpc_fifo_status_ldpc_fifo_full;
                        s_ldpc_fifo_status_strobe_r <= '1';
                        v_state_r := READ_RESPONSE;
                    end if;
                    -- register 'frames_in_transit' at address offset 0xF8 
                    if s_axi_araddr_reg_r = resize(unsigned(BASEADDR) + FRAMES_IN_TRANSIT_OFFSET, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;
                        v_rdata_r(7 downto 0) := s_reg_frames_in_transit_value;
                        s_frames_in_transit_strobe_r <= '1';
                        v_state_r := READ_RESPONSE;
                    end if;
                    --
                    if v_addr_hit then
                        v_rresp_r := AXI_OKAY;
                    else
                        v_rresp_r := AXI_DECERR;
                        -- pragma translate_off
                        report "ARADDR decode error" severity warning;
                        -- pragma translate_on
                        v_state_r := READ_RESPONSE;
                    end if;

                -- Wait for memory read data
                when WAIT_MEMORY_RDATA =>
                    if v_mem_wait_count_r = 0 then
                        -- memory 'bit_mapper_ram' at address offset 0x0
                        if s_axi_araddr_reg_r >= resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET, AXI_ADDR_WIDTH) and 
                            s_axi_araddr_reg_r < resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET + BIT_MAPPER_RAM_DEPTH * 4, AXI_ADDR_WIDTH) then
                            v_rdata_r(31 downto 0) := s_bit_mapper_ram_rdata(31 downto 0);
                        end if;
                        v_state_r      := READ_RESPONSE;
                    else
                        v_mem_wait_count_r := v_mem_wait_count_r - 1;
                    end if;

                -- Generate read response
                when READ_RESPONSE =>
                    s_axi_rvalid_r <= '1';
                    s_axi_rresp_r  <= v_rresp_r;
                    s_axi_rdata_r  <= v_rdata_r;
                    --
                    v_state_r      := DONE;

                -- Write transaction completed, wait for master RREADY to proceed
                when DONE =>
                    if s_axi_rready = '1' then
                        s_axi_rvalid_r <= '0';
                        s_axi_rdata_r   <= (others => '0');
                        v_state_r      := IDLE;
                    end if;
            end case;
        end if;
    end process read_fsm;

    ----------------------------------------------------------------------------
    -- Write-transaction FSM
    --    
    write_fsm : process(axi_aclk, axi_aresetn) is
        type t_state is (IDLE, ADDR_FIRST, DATA_FIRST, UPDATE_REGISTER, DONE);
        variable v_state_r  : t_state;
        variable v_addr_hit : boolean;
        variable v_mem_addr : unsigned(AXI_ADDR_WIDTH-1 downto 0);
    begin
        if axi_aresetn = '0' then
            v_state_r          := IDLE;
            s_axi_awready_r    <= '0';
            s_axi_wready_r     <= '0';
            s_axi_awaddr_reg_r <= (others => '0');
            s_axi_wdata_reg_r  <= (others => '0');
            s_axi_wstrb_reg_r  <= (others => '0');
            s_axi_bvalid_r     <= '0';
            s_axi_bresp_r      <= (others => '0');
            --            
            s_bit_mapper_ram_waddr_r <= (others => '0');
            s_bit_mapper_ram_wen_r <= (others => '0');
            s_bit_mapper_ram_wdata_r <= (others => '0');
            s_config_strobe_r <= '0';
            s_reg_config_enable_dummy_frames_r <= CONFIG_ENABLE_DUMMY_FRAMES_RESET;
            s_reg_config_reset_polyphase_coefficients_r <= CONFIG_RESET_POLYPHASE_COEFFICIENTS_RESET;

        elsif rising_edge(axi_aclk) then
            -- Default values:
            s_axi_awready_r <= '0';
            s_axi_wready_r  <= '0';
            s_bit_mapper_ram_waddr_r <= (others => '0'); -- always reset to zero because of wired OR
            s_bit_mapper_ram_wen_r <= (others => '0');
            s_config_strobe_r <= '0';

            -- Self-clearing fields:
            s_reg_config_reset_polyphase_coefficients_r <= (others => '0');

            case v_state_r is

                -- Wait for the start of a write transaction, which may be 
                -- initiated by either of the following conditions:
                --   * assertion of both AWVALID and WVALID
                --   * assertion of AWVALID
                --   * assertion of WVALID
                when IDLE =>
                    if s_axi_awvalid = '1' and s_axi_wvalid = '1' then
                        s_axi_awaddr_reg_r <= unsigned(s_axi_awaddr); -- save the write-address 
                        s_axi_awready_r    <= '1'; -- acknowledge the write-address
                        s_axi_wdata_reg_r  <= s_axi_wdata; -- save the write-data
                        s_axi_wstrb_reg_r  <= s_axi_wstrb; -- save the write-strobe
                        s_axi_wready_r     <= '1'; -- acknowledge the write-data
                        v_state_r          := UPDATE_REGISTER;
                    elsif s_axi_awvalid = '1' then
                        s_axi_awaddr_reg_r <= unsigned(s_axi_awaddr); -- save the write-address 
                        s_axi_awready_r    <= '1'; -- acknowledge the write-address
                        v_state_r          := ADDR_FIRST;
                    elsif s_axi_wvalid = '1' then
                        s_axi_wdata_reg_r <= s_axi_wdata; -- save the write-data
                        s_axi_wstrb_reg_r <= s_axi_wstrb; -- save the write-strobe
                        s_axi_wready_r    <= '1'; -- acknowledge the write-data
                        v_state_r         := DATA_FIRST;
                    end if;

                -- Address-first write transaction: wait for the write-data
                when ADDR_FIRST =>
                    if s_axi_wvalid = '1' then
                        s_axi_wdata_reg_r <= s_axi_wdata; -- save the write-data
                        s_axi_wstrb_reg_r <= s_axi_wstrb; -- save the write-strobe
                        s_axi_wready_r    <= '1'; -- acknowledge the write-data
                        v_state_r         := UPDATE_REGISTER;
                    end if;

                -- Data-first write transaction: wait for the write-address
                when DATA_FIRST =>
                    if s_axi_awvalid = '1' then
                        s_axi_awaddr_reg_r <= unsigned(s_axi_awaddr); -- save the write-address 
                        s_axi_awready_r    <= '1'; -- acknowledge the write-address
                        v_state_r          := UPDATE_REGISTER;
                    end if;

                -- Update the actual storage element
                when UPDATE_REGISTER =>
                    s_axi_bresp_r               <= AXI_OKAY; -- default value, may be overriden in case of decode error
                    s_axi_bvalid_r              <= '1';
                    --
                    v_addr_hit := false;
                    -- memory 'bit_mapper_ram' at address offset 0x0                    
                    if s_axi_awaddr_reg_r >= resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET, AXI_ADDR_WIDTH) and 
                        s_axi_awaddr_reg_r < resize(unsigned(BASEADDR) + BIT_MAPPER_RAM_OFFSET + BIT_MAPPER_RAM_DEPTH * 4, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;
                        v_mem_addr := s_axi_awaddr_reg_r - unsigned(BASEADDR) - BIT_MAPPER_RAM_OFFSET;
                        s_bit_mapper_ram_waddr_r <= std_logic_vector(v_mem_addr(7 downto 2)); -- output address has 4-byte granularity
                        s_bit_mapper_ram_wen_r <= s_axi_wstrb_reg_r;
                        s_bit_mapper_ram_wdata_r <= s_axi_wdata_reg_r;
                    end if;    
                    -- register 'config' at address offset 0xF0
                    if s_axi_awaddr_reg_r = resize(unsigned(BASEADDR) + CONFIG_OFFSET, AXI_ADDR_WIDTH) then
                        v_addr_hit := true;                        
                        s_config_strobe_r <= '1';
                        -- field 'enable_dummy_frames':
                        if s_axi_wstrb_reg_r(0) = '1' then
                            s_reg_config_enable_dummy_frames_r(0) <= s_axi_wdata_reg_r(0); -- enable_dummy_frames(0)
                        end if;
                        -- field 'reset_polyphase_coefficients':
                        if s_axi_wstrb_reg_r(0) = '1' then
                            s_reg_config_reset_polyphase_coefficients_r(0) <= s_axi_wdata_reg_r(1); -- reset_polyphase_coefficients(0)
                        end if;
                    end if;
                    --
                    if not v_addr_hit then
                        s_axi_bresp_r <= AXI_DECERR;
                        -- pragma translate_off
                        report "AWADDR decode error" severity warning;
                        -- pragma translate_on
                    end if;
                    --
                    v_state_r := DONE;

                -- Write transaction completed, wait for master BREADY to proceed
                when DONE =>
                    if s_axi_bready = '1' then
                        s_axi_bvalid_r <= '0';
                        v_state_r      := IDLE;
                    end if;

            end case;


        end if;
    end process write_fsm;

    ----------------------------------------------------------------------------
    -- Outputs
    --
    s_axi_awready <= s_axi_awready_r;
    s_axi_wready  <= s_axi_wready_r;
    s_axi_bvalid  <= s_axi_bvalid_r;
    s_axi_bresp   <= s_axi_bresp_r;
    s_axi_arready <= s_axi_arready_r;
    s_axi_rvalid  <= s_axi_rvalid_r;
    s_axi_rresp   <= s_axi_rresp_r;
    s_axi_rdata   <= s_axi_rdata_r;

    regs2user.bit_mapper_ram_addr <= s_bit_mapper_ram_waddr_r or s_bit_mapper_ram_raddr_r; -- using wired OR as read/write address multiplexer
    regs2user.bit_mapper_ram_wen <= s_bit_mapper_ram_wen_r;   
    regs2user.bit_mapper_ram_wdata <= s_bit_mapper_ram_wdata_r;
    regs2user.config_strobe <= s_config_strobe_r;
    regs2user.config_enable_dummy_frames <= s_reg_config_enable_dummy_frames_r;
    regs2user.config_reset_polyphase_coefficients <= s_reg_config_reset_polyphase_coefficients_r;
    regs2user.ldpc_fifo_status_strobe <= s_ldpc_fifo_status_strobe_r;
    regs2user.frames_in_transit_strobe <= s_frames_in_transit_strobe_r;

end architecture RTL;
