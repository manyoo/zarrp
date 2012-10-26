module EventsControllerHelper
    require 'net/http'
    require 'net/https'
    require 'cgi'

    $vendorId = "shakeit"
    $vendorPwd = "jtqigs335kult16w4jvwybk0r7xk"
    $addOnId = "293"

    $dateThemes = ["ui-bar-b", "ui-bar-e", "ui-bar-d"]
    $dateThemesLen = $dateThemes.count

    def authenticate_user
        if @access_token.nil?
            return false
        end
        @current_user = User.find_by_access_token @access_token
        if @current_user
            true
        else
            js = getUserProfile @access_token
            if js["response_code"] == "0" || js["response_code"] == "200"
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

    def sendTicket(user, event)
        json = CGI.escape(mkTicketJsonStr(user, event))
        url = URI.parse("https://api.lemon.com/v2/setAddOn/?request=#{json}")
        js = remoteCall(url)
        if js["response_code"] == "0" || js["response_code"] == "200"
            true
        else
            false 
        end
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

    def mkTicketJsonStr(user, event)
        JSON.generate "credentials" => { "vendor_id" => $vendorId, "vendor_pwd" => $vendorPwd },
                      "addOn_type" => { "id_addOn_type" => event.addon_code,
                                        "fields" => [{ "field_key" => "username", "field_value" => "#{user.firstname} #{user.lastname}"},
                                                     { "field_key" => "eventname", "field_value" => event.name },
                                                     { "field_key" => "eventdate", "field_value" => event.time.strftime("%A, %B %d") },
                                                     { "field_key" => "eventprice", "field_value" => event.price },
                                                     { "field_key" => "eventcity", "field_value" => event.city },
                                                     { "field_key" => "eventaddress", "field_value" => event.address },
                                                     { "field_key" => "eventdesc", "field_value" => event.desc },
                                                     { "field_key" => "eventshortdesc", "field_value" => event.short_desc },
                                                     { "field_key" => "eventphone", "field_value" => event.phone },
                                                     { "field_key" => "eventemail", "field_value" => event.email },
                                                     { "field_key" => "eventsubname", "field_value" => event.subname },
                                                     { "field_key" => "eventclub", "field_value" => event.club }
                                                    ]
                                      },
                      "user" => { "user_access_token" => user.access_token }
    end

    def remoteCall(url)
        req = Net::HTTP::Get.new(url.request_uri)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true    # this is important to make it work with HTTPS correctly.
        res = http.start { |h| h.request(req) }
        JSON.parse res.body
    end

    def listFormatDate(date)
      if date == Date.today
        date.strftime("Today, %B %d")
      elsif date == Date.tomorrow
        date.strftime("Tomorrow, %B %d")
      else
        date.strftime("%A, %B %d")
      end
    end

    def mkListDateTheme(dates, date)
      idx = dates.index(date)
      $dateThemes[idx % $dateThemesLen]
    end
end
