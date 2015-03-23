module Zappa
  class Processor
    def normalize(samples, headroom)
      fail 'headroom cannot be positive' if headroom > 0.0
      curr_peak = max_sample(samples)
      targ_peak = 32_768 * db_to_float(headroom)  # calculate this constants
      ratio = (targ_peak / curr_peak)
      mul_samples(samples, ratio)
    end

    def amplify(samples, db) # fix order
      mul_samples(samples, db_to_float(db))
    end

    def invert(samples)
      mul_samples(samples, -1)
    end

    # simple RC FIR
    def high_pass_filter(samples, cutoff)
      rc = 1.0 / (cutoff * 2 * Math::PI)
      dt = 1.0 / 2
      alpha = rc / (rc + dt)
      
      filt_samples = samples
      for i in 1..1
        for ch in 0..1
          filt_samples[i][ch] = (alpha * (filt_samples[i-1][ch] + samples[i][ch] - samples[i-1][ch])).round
        end
      end
      filt_samples
      binding.pry
    end

    def compress(samples, ratio, threshold)
      threshold_value = 32_768 * db_to_float(threshold) # calc this somehow
      samples.each do |f|
        f.map! do |s|
          if s.abs > threshold_value
            s += (threshold_value - s) / ratio if s > 0
            s -= (s + threshold_value) / ratio if s < 0
          end
          s.round
        end
      end
      samples
    end

    private

    def mul_samples(samples, factor)
      samples.map { |f| mul_frame(f, factor) }
    end

    def mul_frame(frame, factor)
      frame.map { |s| clip((s * factor).round) }
    end

    def clip(value, max = 32_768)
      return max if value > max
      return -max if value < (-max)
      value
    end

    def max_sample(samples)
      curr_max = 0
      samples.each do |f|
        f.each { |s| curr_max = s.abs if s.abs > curr_max }
      end
      curr_max
    end

    # convert db values to floats
    def db_to_float(db); 10**(db / 20); end
  end
end
