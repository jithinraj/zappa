# Zappa

Zappa is a high level audio manipulation library for Ruby, inspired by pydub.

## Installation

First install ffmpeg:

    brew install ffmpeg

Add this line to your application's Gemfile:

    gem 'zappa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zappa

## Usage

At the core of Zappa is the Clip, an immutable audio unit. Import a wav file
into a clip:

    require 'zappa'
        
    clip = Zappa::Clip.new
    clip.from_file('this_is_a_song.wav')

The clip will create a safe copy of the wav before you can edit it. Remember,
clips are immutable so any destructive operations return a new clip.

You can slice clips into smaller chunks:

    slice_a = clip.slice(0, 1000)    # clip containing 1st second
    slice_b = clip.slice(1000, 2000) # clip containing 3rd second

You can also join clips:

    joined_clip = slice_a + slice_b  # clip containing 1st and 3rd seconds

Once you're done editing a clip, you can export it:

    joined_clip.export('output.wav')

That's it for now. DSP tools are coming soon!


## Contributing

1. Fork it ( https://github.com/[my-github-username]/zappa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
