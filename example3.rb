run_file "~/Code/sonic-pi-workshop/patterns.rb"

use_bpm 125
set :beats_in_bar, 4

live_loop :bass do
  sample_bars :drum_bass_soft, "6354|6 5 "
end

live_loop :sn do
  sample_bars :drum_snare_soft,
    #               1.^.2.^.3.^.4.^.
    " 6 6| 6 6| 6 6|    3 5  1615143"
end