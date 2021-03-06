-- -----------------------------------------------------------------------------
-- 'dvbs2_tx_wrapper_regmap' Register Definitions
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

package dvbs2_tx_wrapper_regmap_regs_pkg is

    -- Type definitions
    type slv1_array_t is array(natural range <>) of std_logic_vector(0 downto 0);
    type slv2_array_t is array(natural range <>) of std_logic_vector(1 downto 0);
    type slv3_array_t is array(natural range <>) of std_logic_vector(2 downto 0);
    type slv4_array_t is array(natural range <>) of std_logic_vector(3 downto 0);
    type slv5_array_t is array(natural range <>) of std_logic_vector(4 downto 0);
    type slv6_array_t is array(natural range <>) of std_logic_vector(5 downto 0);
    type slv7_array_t is array(natural range <>) of std_logic_vector(6 downto 0);
    type slv8_array_t is array(natural range <>) of std_logic_vector(7 downto 0);
    type slv9_array_t is array(natural range <>) of std_logic_vector(8 downto 0);
    type slv10_array_t is array(natural range <>) of std_logic_vector(9 downto 0);
    type slv11_array_t is array(natural range <>) of std_logic_vector(10 downto 0);
    type slv12_array_t is array(natural range <>) of std_logic_vector(11 downto 0);
    type slv13_array_t is array(natural range <>) of std_logic_vector(12 downto 0);
    type slv14_array_t is array(natural range <>) of std_logic_vector(13 downto 0);
    type slv15_array_t is array(natural range <>) of std_logic_vector(14 downto 0);
    type slv16_array_t is array(natural range <>) of std_logic_vector(15 downto 0);
    type slv17_array_t is array(natural range <>) of std_logic_vector(16 downto 0);
    type slv18_array_t is array(natural range <>) of std_logic_vector(17 downto 0);
    type slv19_array_t is array(natural range <>) of std_logic_vector(18 downto 0);
    type slv20_array_t is array(natural range <>) of std_logic_vector(19 downto 0);
    type slv21_array_t is array(natural range <>) of std_logic_vector(20 downto 0);
    type slv22_array_t is array(natural range <>) of std_logic_vector(21 downto 0);
    type slv23_array_t is array(natural range <>) of std_logic_vector(22 downto 0);
    type slv24_array_t is array(natural range <>) of std_logic_vector(23 downto 0);
    type slv25_array_t is array(natural range <>) of std_logic_vector(24 downto 0);
    type slv26_array_t is array(natural range <>) of std_logic_vector(25 downto 0);
    type slv27_array_t is array(natural range <>) of std_logic_vector(26 downto 0);
    type slv28_array_t is array(natural range <>) of std_logic_vector(27 downto 0);
    type slv29_array_t is array(natural range <>) of std_logic_vector(28 downto 0);
    type slv30_array_t is array(natural range <>) of std_logic_vector(29 downto 0);
    type slv31_array_t is array(natural range <>) of std_logic_vector(30 downto 0);
    type slv32_array_t is array(natural range <>) of std_logic_vector(31 downto 0);

    -- User-logic ports (from user-logic to register file)
    type user2regs_t is record
        bit_mapper_ram_rdata : std_logic_vector(31 downto 0); -- read data for memory 'bit_mapper_ram'
        ldpc_fifo_status_ldpc_fifo_entries : std_logic_vector(13 downto 0); -- value of register 'ldpc_fifo_status', field 'ldpc_fifo_entries'
        ldpc_fifo_status_ldpc_fifo_empty : std_logic_vector(0 downto 0); -- value of register 'ldpc_fifo_status', field 'ldpc_fifo_empty'
        ldpc_fifo_status_ldpc_fifo_full : std_logic_vector(0 downto 0); -- value of register 'ldpc_fifo_status', field 'ldpc_fifo_full'
        frames_in_transit_value : std_logic_vector(7 downto 0); -- value of register 'frames_in_transit', field 'value'
    end record;
    
    -- User-logic ports (from register file to user-logic)
    type regs2user_t is record
        bit_mapper_ram_addr : std_logic_vector(5 downto 0); -- read/write address for memory 'bit_mapper_ram'
        bit_mapper_ram_wdata : std_logic_vector(31 downto 0); -- write data for memory 'bit_mapper_ram'         
        bit_mapper_ram_wen : std_logic_vector(3 downto 0); -- byte-wide write-enable for memory 'bit_mapper_ram'
        config_strobe : std_logic; -- Strobe signal for register 'config' (pulsed when the register is written from the bus}
        config_enable_dummy_frames : std_logic_vector(0 downto 0); -- Value of register 'config', field 'enable_dummy_frames'
        config_reset_polyphase_coefficients : std_logic_vector(0 downto 0); -- Value of register 'config', field 'reset_polyphase_coefficients'
        ldpc_fifo_status_strobe : std_logic; -- Strobe signal for register 'ldpc_fifo_status' (pulsed when the register is read from the bus}
        frames_in_transit_strobe : std_logic; -- Strobe signal for register 'frames_in_transit' (pulsed when the register is read from the bus}
    end record;

    -- Revision number of the 'dvbs2_tx_wrapper_regmap' register map
    constant DVBS2_TX_WRAPPER_REGMAP_REVISION : natural := 16;

    -- Default base address of the 'dvbs2_tx_wrapper_regmap' register map 
    constant DVBS2_TX_WRAPPER_REGMAP_DEFAULT_BASEADDR : unsigned(31 downto 0) := unsigned'(x"00000000");
    
    -- Register 'bit_mapper_ram'
    constant BIT_MAPPER_RAM_OFFSET : unsigned(31 downto 0) := unsigned'(x"00000000"); -- address offset of the 'bit_mapper_ram' register
    constant BIT_MAPPER_RAM_DEPTH : natural := 60; -- depth of the 'bit_mapper_ram' memory, in elements
    constant BIT_MAPPER_RAM_READ_LATENCY : natural := 1; -- read latency of the 'bit_mapper_ram' memory, in clock cycles
    -- Field 'bit_mapper_ram.value'
    constant BIT_MAPPER_RAM_VALUE_BIT_OFFSET : natural := 0; -- bit offset of the 'value' field
    constant BIT_MAPPER_RAM_VALUE_BIT_WIDTH : natural := 32; -- bit width of the 'value' field
    constant BIT_MAPPER_RAM_VALUE_RESET : std_logic_vector(31 downto 0) := std_logic_vector'("00000000000000000000000000000000"); -- reset value of the 'value' field
    
    -- Register 'config'
    constant CONFIG_OFFSET : unsigned(31 downto 0) := unsigned'(x"000000F0"); -- address offset of the 'config' register
    -- Field 'config.enable_dummy_frames'
    constant CONFIG_ENABLE_DUMMY_FRAMES_BIT_OFFSET : natural := 0; -- bit offset of the 'enable_dummy_frames' field
    constant CONFIG_ENABLE_DUMMY_FRAMES_BIT_WIDTH : natural := 1; -- bit width of the 'enable_dummy_frames' field
    constant CONFIG_ENABLE_DUMMY_FRAMES_RESET : std_logic_vector(0 downto 0) := std_logic_vector'("0"); -- reset value of the 'enable_dummy_frames' field
    -- Field 'config.reset_polyphase_coefficients'
    constant CONFIG_RESET_POLYPHASE_COEFFICIENTS_BIT_OFFSET : natural := 1; -- bit offset of the 'reset_polyphase_coefficients' field
    constant CONFIG_RESET_POLYPHASE_COEFFICIENTS_BIT_WIDTH : natural := 1; -- bit width of the 'reset_polyphase_coefficients' field
    constant CONFIG_RESET_POLYPHASE_COEFFICIENTS_RESET : std_logic_vector(1 downto 1) := std_logic_vector'("0"); -- reset value of the 'reset_polyphase_coefficients' field
    
    -- Register 'ldpc_fifo_status'
    constant LDPC_FIFO_STATUS_OFFSET : unsigned(31 downto 0) := unsigned'(x"000000F4"); -- address offset of the 'ldpc_fifo_status' register
    -- Field 'ldpc_fifo_status.ldpc_fifo_entries'
    constant LDPC_FIFO_STATUS_LDPC_FIFO_ENTRIES_BIT_OFFSET : natural := 0; -- bit offset of the 'ldpc_fifo_entries' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_ENTRIES_BIT_WIDTH : natural := 13; -- bit width of the 'ldpc_fifo_entries' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_ENTRIES_RESET : std_logic_vector(13 downto 0) := std_logic_vector'("0000000000000"); -- reset value of the 'ldpc_fifo_entries' field
    -- Field 'ldpc_fifo_status.ldpc_fifo_empty'
    constant LDPC_FIFO_STATUS_LDPC_FIFO_EMPTY_BIT_OFFSET : natural := 16; -- bit offset of the 'ldpc_fifo_empty' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_EMPTY_BIT_WIDTH : natural := 1; -- bit width of the 'ldpc_fifo_empty' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_EMPTY_RESET : std_logic_vector(16 downto 16) := std_logic_vector'("0"); -- reset value of the 'ldpc_fifo_empty' field
    -- Field 'ldpc_fifo_status.ldpc_fifo_full'
    constant LDPC_FIFO_STATUS_LDPC_FIFO_FULL_BIT_OFFSET : natural := 17; -- bit offset of the 'ldpc_fifo_full' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_FULL_BIT_WIDTH : natural := 1; -- bit width of the 'ldpc_fifo_full' field
    constant LDPC_FIFO_STATUS_LDPC_FIFO_FULL_RESET : std_logic_vector(17 downto 17) := std_logic_vector'("0"); -- reset value of the 'ldpc_fifo_full' field
    
    -- Register 'frames_in_transit'
    constant FRAMES_IN_TRANSIT_OFFSET : unsigned(31 downto 0) := unsigned'(x"000000F8"); -- address offset of the 'frames_in_transit' register
    -- Field 'frames_in_transit.value'
    constant FRAMES_IN_TRANSIT_VALUE_BIT_OFFSET : natural := 0; -- bit offset of the 'value' field
    constant FRAMES_IN_TRANSIT_VALUE_BIT_WIDTH : natural := 8; -- bit width of the 'value' field
    constant FRAMES_IN_TRANSIT_VALUE_RESET : std_logic_vector(7 downto 0) := std_logic_vector'("00000000"); -- reset value of the 'value' field

end dvbs2_tx_wrapper_regmap_regs_pkg;
