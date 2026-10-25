# Include this in your Sonic Pi code with
# eval_file "...path-to/helpers.rb"

set :beats_in_bar, 4

def bar()
  (beat / get[:beats_in_bar]).to_i
end

def bar_pattern(pattern)
  pattern[bar % pattern.length]
end

def play_sample_pattern(asample, amps, beats, rate: 1, gain: 1)
  # Play this sample pattern over this number of beats
  beat_length = beats.to_f/amps.length
  amps.each do |item|
    if item.is_a?(Array) then
      # This item is a sub-sequence of amps
      play_sample_pattern asample, item, beat_length, rate: rate, gain: gain
    else
      if 0 < item and item <= 9 and gain > 0 then
        # This item is a velocity (loudness)
        sample asample, amp: (item/9.0)*gain, rate: rate
      end
      sleep beat_length
    end
  end
end

def sample_bars(asample, bars, rate: 1, gain: 1)
  bars.each do |bar|
    play_sample_pattern asample, bar, get[:beats_in_bar], rate: rate, gain: gain
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
