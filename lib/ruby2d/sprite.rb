# sprite.rb

module Ruby2D
  class Sprite
    include Renderable

    attr_accessor :x, :y, :width, :height, :loop,
                  :clip_x, :clip_y, :clip_width, :clip_height, :data

    def initialize(path, opts = {})

      unless RUBY_ENGINE == 'opal'
        unless File.exists? path
          raise Error, "Cannot find sprite image file `#{path}`"
        end
      end

      @path = path
      @x = opts[:x] || 0
      @y = opts[:y] || 0
      @z = opts[:z] || 0
      @width  = opts[:width]  || nil
      @height = opts[:height] || nil

      @frame_time = opts[:time] || nil
      @start_time = 0.0
      @loop = opts[:loop] || false

      @animations = opts[:animations] || {}
      @playing = false
      @playing_animation = :default
      @default_frame = opts[:default] || 0
      @current_frame = @default_frame

      ext_init(@path)
      @clip_x = 0
      @clip_y = 0
      @clip_width  = opts[:clip_width] || @width
      @clip_height = opts[:clip_height] || @height
      @animations[:default] = 0..(@width / @clip_width) - 1  # set default animation
      add
    end

    def play(animation = nil, loop = nil)
      if !@playing || animation != nil
        @playing = true

        # If the animation is a range, play through frames horizontally
        if @animations[animation].class == Range
          @playing_animation = animation
          @current_frame = @animations[@playing_animation].first
          set_frame_position
        end

        # Set looping
        unless loop == nil
          @loop = loop == :loop ? true : false
        end

        restart_time
      end
    end

    # Stop the current animation and set to the default frame
    def stop
      @playing = false
      @current_frame = @default_frame
      set_frame_position
    end

    # Set the position of the clipping retangle based on the current frame
    def set_frame_position
      @clip_x = @current_frame * @clip_width
    end

    # Calculate the time in ms
    def elapsed_time
      (Time.now.to_f - @start_time) * 1000
    end

    # Restart the timer
    def restart_time
      @start_time = Time.now.to_f
    end

    # Update the sprite animation, called by `Sprite#ext_render`
    def update
      if @playing

        # Advance the frame
        unless elapsed_time <= @frame_time
          @current_frame += 1
          set_frame_position
          restart_time
        end

        # Reset to the starting frame if all frames played
        if @current_frame > @animations[@playing_animation].last
          @current_frame = @animations[@playing_animation].first
          set_frame_position
          unless @loop then stop end
        end
      end
    end

  end
end
