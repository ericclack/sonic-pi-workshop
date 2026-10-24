# Include this in your Sonic Pi code with
# eval_file "...path-to/helpers.rb"

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

# -----------------------------------------------------

def play_note_seq(asynth, notes, beats, amp: 1)
  # Play a sequence of notes across this number beats
  beat_length = beats.to_f/notes.length
  
  notes.each do |item|
    if item.is_a?(Array) then
      # This item is a sequence of notes
      play_note_seq asynth, item, beat_length, amp: amp
    else
      if item != 0 then
        # This item is a note
        play item, amp: amp
      end
      sleep beat_length
    end
  end
end

def note_bars(asynth, bars, amp: 1)
  use_synth asynth
  bars.each do |bar|
    play_note_seq asynth, bar, get[:beats_in_bar], amp: amp
  end
end
