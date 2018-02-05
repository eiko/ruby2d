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
      # @image_width  = 504
      # @image_height = 84

      @clip_x = 0
      @clip_y = 0

      @frame_time = opts[:time] || nil
      @start_time = 0.0
      @loop = opts[:loop] || false

      @animations = {}
      @playing = false

      ext_init(@path)

      @clip_width  = opts[:clip_width] || nil
      @clip_height = @height
      add
    end

    def play
      unless @playing
        @playing = true
        restart_time
      end
    end

    def stop
      @playing = false
    end

    def elapsed_time
      (Time.now.to_f - @start_time) * 1000
    end

    def restart_time
      @start_time = Time.now.to_f
    end

    # Update the sprite animation, called by `Sprite#ext_render`
    def update
      if @playing

        # Advance the frame
        unless elapsed_time <= @frame_time
          @clip_x = @clip_x + @clip_width
          restart_time
        end

        # After all frames, reset or stop
        if @clip_x >= @width
          @clip_x = 0
          unless @loop then stop end
        end

      end
    end

    private

  end
end
