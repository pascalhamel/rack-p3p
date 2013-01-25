# Shamelessly ripped from http://www.mail-archive.com/rubyonrails-core@googlegroups.com/msg09777.html
module Rack
  class P3p
    POLICY = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'

    def initialize(app)
      @app = app
    end

    def call(env)
      response = @app.call(env)
      insert_p3p(response)
    end

    private
      def insert_p3p(response)
        if response.first == 304
          response[1].delete('Set-Cookie')
        else
          response[1].update('P3P' => POLICY)
        end
        response
      end
  end
end
