use_bpm 125
set :beats_in_bar, 4

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

def bar_patterns(asample, bars, rate: 1, gain: 1)
  bars.split('|') do |amps|
    sample_pattern(asample, amps, rate: rate, gain: gain)
  end
end

live_loop :bass do
  bar_patterns :drum_bass_soft, "555 |555 |5 5 |5"
  #sample_pattern :drum_bass_soft, "555 ", gain: 1
end

live_loop :sn do
  bar_patterns :drum_snare_hard, "  6 |  6 | 2 5|315315"
end

live_loop :hh do
  bar_patterns :drum_cymbal_closed, " 7 7 7 7"
end

