eval_file "~/Code/sonic-pi-workshop/lib/helpers.rb"
use_bpm 125
_ = 0 # This is a rest

live_loop :bass do
  sample_bars :drum_bass_soft,
    #"6354|6 5 "
    [[6, 3, 5, 4], [6, 5]]
end

live_loop :sn do
  sample_bars :drum_snare_soft,
    [[_, 6, _ ,6], [_, 6, _ ,6], [_, 6, _ ,6],
     [[_, 3], [_, 5], [_, 1, 6, 1], [5, 1, 4, 3]]]
    
end

live_loop :hh do
  sample_bars :drum_cymbal_closed, [[_, 7, _, 7, _, 7, _, 7]]
end

live_loop :click do
  sample_bars :perc_snap2, [[2], [2], [2], [2, 2]]
end

live_loop :melody do
  note_bars :fm,
  [
    [[:c5,:c4,:c5,:c4],  :f4, :c4, :c3],
    [:c5, :f4, [_,_,_,:c4], [_,:g3]],
  ], amp: 0.3
end
