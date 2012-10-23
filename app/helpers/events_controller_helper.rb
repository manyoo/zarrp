module EventsControllerHelper
    require 'net/http'
    require 'net/https'
    require 'cgi'

    $vendorId = "manyoostudio"
    $vendorPwd = "9c5d6uesb9eyvh5b1id44ijoouzx"
    $addOnId = "221"
    $addOnAccessToken = "7610626|ro7gz824eei2lghed2xqhrja29vg"

    def authenticate_user
        if @addon_token != $addOnAccessToken
            return false
        end
        @current_user = User.find_by_access_token @access_token
        if @current_user
            true
        else
            js = getUserProfile @access_token
            if js["response_code"] == "0"
                users = js["users"]
                if users.nil? || users.empty?
                    return false
                else
                    user = users[0]
                    @current_user = User.new firstname:user["firstname"], lastname:user["lastname"], gender:user["gender"],
                                             default_currency:user["default_currency"], date_of_birth:user["date_of_birth"],
                                             access_token:@access_token
                    @current_user.save
                    return true
                end
            else
                return false
            end
        end
    end

    def sendTicket(user, ticket)
        json = CGI.escape(mkTicketJsonStr(user, ticket))
        url = URI.parse("https://api.lemon.com/v2/setAddOn/?request=#{json}")
        remoteCall(url)
    end

    def getUserProfile(access_token)
        json = CGI.escape(mkUserJsonStr(access_token))
        url = URI.parse("https://api.lemon.com/v2/getUsers/?request=#{json}")
        remoteCall(url)
    end

    def mkUserJsonStr(access_token)
        JSON.generate "credentials" => { "vendor_id" => $vendorId, "vendor_pwd" => $vendorPwd },
                      "filters" => { "id_addOn_type" => $addOnId, "user_access_token" => access_token }
    end

    def mkTicketJsonStr(user, ticket)
        JSON.generate "credentials" => { "vendor_id" => $vendorId, "vendor_pwd" => $vendorPwd },
                      "addOn_type" => { "id_addOn_type" => ticket.addOnId,
                                        "fields" => [] }
    end

    def remoteCall(url)
        req = Net::HTTP::Get.new(url.request_uri)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true    # this is important to make it work with HTTPS correctly.
        res = http.start { |h| h.request(req) }
        JSON.parse res.body
    end
end
