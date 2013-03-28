require 'cgi'

class Mxit
    @@mock_mxit_headers = {
        "HTTP_X_MXIT_LOCATION"=>"ZA,,06,,,Germiston,83354,81131486,7efb4d", #
        "HTTP_X_MXIT_LOGIN"=>"emilesilvis7", #m41162520002
        "HTTP_X_MXIT_USERID_R"=>"web-client", #
        "HTTP_X_MXIT_HOME"=>"http://www.glio.co.za", 
        "HTTP_X_MXIT_NICK"=>"Emile+Silvis", #
        #"HTTP_X_MXIT_USER_INPUT"=>"This+is+my+message+", #
        "HTTP_X_MXIT_PROFILE"=>"en,ZA,1976-05-12,Male,1", #
        "HTTP_X_MXIT_CONTACT"=>"gauteng_events", #
        "HTTP_UA_PIXELS"=>"800x1280",  #
        "HTTP_X_FORWARDED_FOR"=>"41.56.72.123", # 
        "HTTP_X_DEVICE_USER_AGENT" => "Mock" #
    }

    @@province_codes = {
        "01" => "North-Western Province",
        "02" => "KwaZulu-Natal",
        "03" => "Free State",
        "05" => "Eastern Cape",
        "06" => "Gauteng",
        "07" => "Mpumalanga",
        "08" => "Northern Cape",
        "09" => "Limpopo",
        "10" => "North-West",
        "11" => "Western Cape"
    }

    def initialize(request_env)
        @env =  @@mock_mxit_headers.merge request_env
    end


    def user_id
        @env['HTTP_X_MXIT_USERID_R']
    end

    def nickname
        CGI::unescape @env['HTTP_X_MXIT_NICK']
    end

    def message
        CGI::unescape @env['HTTP_X_MXIT_USER_INPUT'] rescue nil
    end

    def country_code
        @env['HTTP_X_MXIT_LOCATION'].split(',')[0]
    end

    def province_name
        code = @env['HTTP_X_MXIT_LOCATION'].split(',')[2]
        @@province_codes[code]
    end

end
