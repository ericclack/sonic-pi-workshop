use_bpm 115
set :beats_in_bar, 5

def bar()
  (beat / get[:beats_in_bar]).to_i
end

def bar_pattern(pattern)
  pattern[bar % pattern.length]
end

def sample_pattern(asample, amps, rate: 1, gain: 1)
  beat_length = get[:beats_in_bar].to_f/amps.length
  amps.each_char do |c|
    v = c.ord - "0".ord
    if 0 <= v and v <= 9 and gain > 0 then
      sample asample, amp: (v/9.0)*gain, rate: rate
    end
    sleep beat_length
  end
end

live_loop :bass do
  case bar_pattern "AAAB"
  #                                1&2&3&4&5&
  when "A"
    sample_pattern :drum_bass_soft, "9 7 5 8 5 ", gain: 1
  when "B"
    sample_pattern :drum_bass_soft, "9 7  5 8 5", gain: 1.2
  end
end

live_loop :sn do
  case bar_pattern "AAAB"
  #                                   1&2&3&4&5&
  when "A"
    sample_pattern :drum_snare_hard, "  5   5  3", rate: 1.2, gain: 1
  when "B"
    sample_pattern :drum_snare_hard, "      2369", rate: 1.2, gain: 1.2
  end
end

live_loop :hh, delay: 16 do
  case bar_pattern "AAAB"
  #                                      1 & 2 & 3 & 4 & 5 &_
  when "A"
    sample_pattern :drum_cymbal_closed, "  7   7   7   7   7 "
  when "B"
    sample_pattern :drum_cymbal_closed, "  7 2 721 721 721 72"
  end
end

live_loop :effects do
  #                                  1 2 3 4 5
  sample_pattern :drum_tom_hi_soft, "2 342 3924", gain: 1.2
end

live_loop :stuff do
  case bar_pattern "ABC"
  #                                 1 2 3 4 5
  when "A"
    sample_pattern :mehackit_phone1, "3       5 ", rate: 1
  when "B"
    sample_pattern :mehackit_phone1, "2424242462", rate: 2
  when "C"
    sample_pattern :mehackit_phone1, " 3 2 ", rate: 0.8
  end
end

live_loop :stuff2 do
  case bar_pattern "AB"
  when "A"
    sample_pattern :perc_door,    " 3"
  when "B"
    #                              1 2 3 4 5_
    sample_pattern :perc_impact1, " 6 4 1 2 4", rate: 2, gain: 1
  end
end


