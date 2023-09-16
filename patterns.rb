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

def sample_bars(asample, bars, rate: 1, gain: 1)
  bars.split('|') do |amps|
    sample_pattern(asample, amps, rate: rate, gain: gain)
  end
end

def note_pattern(asynth, bar, amp: 1)
  use_synth asynth
  beat_length = get[:beats_in_bar].to_f/bar.length
  puts beat_length
  bar.each do |note|
    if note != 0 then
      play note, amp: amp
    end
    sleep beat_length
  end
end

def note_bars(asynth, bars, amp: 1)
  bars.each do |bar|
    note_pattern asynth, bar, amp: amp
  end
end
