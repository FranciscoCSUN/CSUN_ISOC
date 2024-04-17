LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RS_Encoder_tb IS
END RS_Encoder_tb;

ARCHITECTURE behavior OF RS_Encoder_tb IS 

component ErrorGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        dataIn                            :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        validIn                           :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        dataOut                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic
        );
END component;

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT RS_Encoder
    PORT(
        clk        : IN  std_logic;
        reset      : IN  std_logic;
        clk_enable : IN  std_logic;
        dataIn     : IN  std_logic_vector(7 DOWNTO 0);
        startIn    : IN  std_logic;
        endIn      : IN  std_logic;
        validIn    : IN  std_logic;
        ce_out     : OUT std_logic;
        dataOut    : OUT std_logic_vector(7 DOWNTO 0);
        startOut   : OUT std_logic;
        endOut     : OUT std_logic;
        validOut   : OUT std_logic
    );
    END COMPONENT;
Component RS_Decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        dataIn                            :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        startIn                           :   IN    std_logic;
        endIn                             :   IN    std_logic;
        validIn                           :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        dataOut                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        startOut                          :   OUT   std_logic;
        endOut                            :   OUT   std_logic;
        validOut                          :   OUT   std_logic;
        errOut                            :   OUT   std_logic
        );
    END component;
    
    -- Inputs
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal clk_enable : std_logic := '0';
    signal Enc_dataIn, Dec_dataIn     : std_logic_vector(7 DOWNTO 0) := (others => '0');
    signal Enc_startIn   : std_logic := '0';
    signal Enc_endIn      : std_logic := '0';
    signal Enc_validIn : std_logic := '0';

    -- Outputs
    signal Enc_ce_out, Dec_ce_out, Err_ce_out    : std_logic;
    signal Enc_dataOut, Dec_dataOut, Err_DataOut   : std_logic_vector(7 DOWNTO 0);
    signal Enc_startOut, Dec_startOut, Err_startOut  : std_logic;
    signal Enc_endOut, Dec_endOut, Err_EndOut    : std_logic;
    signal Enc_validOut, Dec_validOut, Err_ValidOut  : std_logic;
    signal errOut   : std_logic := '0';
    
    -- Inputs
    signal Enc_dataIn1, Dec_dataIn1     : std_logic_vector(7 DOWNTO 0) := (others => '0');
    signal Enc_startIn1   : std_logic := '0';
    signal Enc_endIn1      : std_logic := '0';
    signal Enc_validIn1 : std_logic := '0';

    -- Outputs
    signal Enc_ce_out1, Dec_ce_out1, Err_ce_out1    : std_logic;
    signal Enc_dataOut1, Dec_dataOut1, Err_DataOut1   : std_logic_vector(7 DOWNTO 0);
    signal Enc_startOut1, Dec_startOut1, Err_startOut1  : std_logic;
    signal Enc_endOut1, Dec_endOut1, Err_EndOut1    : std_logic;
    signal Enc_validOut1, Dec_validOut1, Err_ValidOut1  : std_logic;
    signal errOut1   : std_logic := '0';
    -- Clock period definitions
    constant clk_period : time := 10 ns;
    
    signal enc_total : std_logic_vector(7 downto 0);
    signal dec_total : std_logic_vector(7 downto 0);

BEGIN

    -- Create a source of error
       --Dec_Datain <= Enc_dataOut or x"01";

  
    enc_total <= enc_dataOut1 or enc_dataOut;
    dec_total <= dec_dataOut1 or dec_dataOut;

    encoder: RS_Encoder PORT MAP (
        clk        => clk,
        reset      => reset,
        clk_enable => clk_enable,
        dataIn     => Enc_dataIn,
        startIn    => Enc_startIn,
        endIn      => Enc_endIn,
        validIn    => Enc_validIn,
        ce_out     => Enc_ce_out,
        dataOut    => Enc_dataOut,
        startOut   => Enc_startOut,
        endOut     => Enc_endOut,
        validOut   => Enc_validOut
    );
    
      Errormaker :  ErrorGen 
  PORT map( clk     => clk,                     --:   IN    std_logic;
        reset       => reset,                      --:   IN    std_logic;
        clk_enable  => Enc_ce_out,                       --:   IN    std_logic;
        dataIn      => Enc_DataOut,                      --:   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        startIn     => Enc_startOut,                      --:   IN    std_logic;
        endIn       => Enc_endOut,                        --:   IN    std_logic;
        validIn     => Enc_validOut,                       --:   IN    std_logic;
        ce_out      => Err_ce_out,                      --:   OUT   std_logic;
        dataOut     => Err_dataOut,                      --:   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        startOut    => Err_Startout,                      --:   OUT   std_logic;
        endOut      => Err_Endout,                      --:   OUT   std_logic;
        validOut    => Err_validOut                      --:   OUT   std_logic
        );
        
    decoder: RS_Decoder PORT MAP (
        clk        => clk,
        reset      => reset,
        clk_enable => Err_ce_out,
        dataIn     => Err_dataOut,
        startIn    => Err_startOut,
        endIn      => Err_endOut,
        validIn    => Err_validOut,
        ce_out     => Dec_ce_out,
        dataOut    => Dec_dataOut,
        startOut   => Dec_startOut,
        endOut     => Dec_endOut,
        validOut   => Dec_validOut,
        errOut => errOut
    );
    
    
    encoder1: RS_Encoder PORT MAP (
        clk        => clk,
        reset      => reset,
        clk_enable => clk_enable,
        dataIn     => Enc_dataIn1,
        startIn    => Enc_startIn1,
        endIn      => Enc_endIn1,
        validIn    => Enc_validIn1,
        ce_out     => Enc_ce_out1,
        dataOut    => Enc_dataOut1,
        startOut   => Enc_startOut1,
        endOut     => Enc_endOut1,
        validOut   => Enc_validOut1
    );
    
      Errormaker1 :  ErrorGen 
  PORT map( clk     => clk,                     --:   IN    std_logic;
        reset       => reset,                      --:   IN    std_logic;
        clk_enable  => Enc_ce_out1,                       --:   IN    std_logic;
        dataIn      => Enc_DataOut1,                      --:   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        startIn     => Enc_startOut1,                      --:   IN    std_logic;
        endIn       => Enc_endOut1,                        --:   IN    std_logic;
        validIn     => Enc_validOut1,                       --:   IN    std_logic;
        ce_out      => Err_ce_out1,                      --:   OUT   std_logic;
        dataOut     => Err_dataOut1,                      --:   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        startOut    => Err_Startout1,                      --:   OUT   std_logic;
        endOut      => Err_Endout1,                      --:   OUT   std_logic;
        validOut    => Err_validOut1                      --:   OUT   std_logic
        );
        
    decoder1: RS_Decoder PORT MAP (
        clk        => clk,
        reset      => reset,
        clk_enable => clk_enable,
        dataIn     => Enc_dataIn,
        startIn    => Enc_startIn1,
        endIn      => Enc_endIn1,
        validIn    => Enc_validIn1,
        ce_out     => Dec_ce_out1,
        dataOut    => Dec_dataOut1,
        startOut   => Dec_startOut1,
        endOut     => Dec_endOut1,
        validOut   => Dec_validOut1,
        errOut => errOut1
    );
    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
begin        
    -- hold reset state for 100 ns.
    wait for 100 ns;    
    reset <= '1';
    wait for 100 ns;
    reset <= '0';

    clk_enable <= '1';  -- Enable the clock

    for i in 0 to 239 loop
        if i = 0 then
            Enc_startIn <= '1';  -- Signal the start only for the first byte
        else
            Enc_startIn <= '0';
        end if;

        if i = 239 then
            Enc_endIn <= '1';    -- Signal the end only for the last byte
        else
            Enc_endIn <= '0';
        end if;

        Enc_validIn <= '1';           -- Indicate the data is valid
        Enc_dataIn <= std_logic_vector(to_unsigned(i, 8)); -- Send data (example with incremental values)

        wait for clk_period;      -- Wait for one clock period

        Enc_validIn <= '0';           -- Indicate data is no longer valid if necessary for your design
    end loop;

    -- Additional wait to observe the last byte being processed
    wait for 10us;

    -- Finish the simulation
    --wait;
end process;

process begin
    wait until Enc_endOut = '1';
    for i in 0 to 239 loop
        if i = 0 then
            Enc_startIn1 <= '1';  -- Signal the start only for the first byte
        else
            Enc_startIn1 <= '0';
        end if;

        if i = 239 then
            Enc_endIn1 <= '1';    -- Signal the end only for the last byte
        else
            Enc_endIn1 <= '0';
        end if;

        Enc_validIn1 <= '1';           -- Indicate the data is valid
        Enc_dataIn1 <= std_logic_vector(to_unsigned(i, 8)); -- Send data (example with incremental values)

        wait for clk_period;      -- Wait for one clock period

        Enc_validIn1 <= '0';           -- Indicate data is no longer valid if necessary for your design
    end loop;

    -- Additional wait to observe the last byte being processed
    wait for 10us;

end process;

END;
