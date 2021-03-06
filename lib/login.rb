#!/usr/bin/ruby

# xraystyle's GApps User Provisioning Tool 
# https://github.com/xraystyle/google-apps-management-ruby

class LogIn
   
   attr_accessor :username, :gapps_session

   
   def initialize(user=nil)
      ask_for_creds(user)
      begin
         @gapps_session = ProvisioningApi.new(@username, @password)
      rescue 
         puts "Log-in failed. Likely incorrect username or password.\n Retry? (y/n)"
         response = gets.chomp.downcase.strip
         case response
         when "y" || "yes"
            @gapps_session = nil
            @username = nil
            user = nil
            @password = nil
            initialize
         when "no" || "n"
            puts "Check your login credentials, then try again."
            exit!
         end
         
      end
         
   end
   
   #### Ask For Credentials ####
   # ask_for_creds requests the user's email address for
   # their GApps domain and their password. It uses the
   # 'highline' gem to supress printing of the password
   # on the screen in plaintext.
   
   def ask_for_creds(user=nil)
      if user
         @username = user
      else
         print "Enter your GApps email address: "
         @username = gets.chomp.strip.downcase         
         # using highline for input on more than one run of a loop causes intermittent errors
         # in Ruby 1.8.7 on Mac OS X 10.8 for some reason. Changed from the highline 'ask' below
         # to the 'print/gets' above.
         #@username = ask("Enter your GApps email address: ").strip.downcase if @username == nil
      end
      @password = ask("Enter your password:  ") { |q| q.echo = "x" }
   end
    
end