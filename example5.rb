run_file "~/Code/sonic-pi-workshop/patterns.rb"

use_bpm 140
set :beats_in_bar, 4

s = "0" # silence

live_loop :bass do
  #    1^2^3^4^
  a = "6 5 4 5 "
  #    1.^.2.^.3.^.4.^.
  b = "6  5    4    5  "
  sample_bars :drum_bass_soft, bars([a,b])
end

live_loop :sn do
  #    1^2^3^4^
  #    1.^.2.^.3.^.4.^.
  a = "6    3546    453"
  sample_bars :drum_snare_soft, bars([s])
end

live_loop :hh do
  #    1^2^3^4^
  #    1.^.2.^.3.^.4.^.
  a = "  4   4   3   4 "
  b = "  4  6454 3   4 "
  c = "  4   45623   45"
  sample_bars :drum_cymbal_closed, bars([a,c])
end
