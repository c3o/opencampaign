xml.instruct! :xml, :version=>"1.0" 
xml.comment! "COPYRIGHT Userplane 2004 (http://www.userplane.com)"
xml.comment! "WR version 1.6.0"
xml.vrappserver do
  
  # params[:callID]
  # params[:domainID]
  
  case @function
  
    when 'getAdminIPAddresses' # IPs from which all requests may use the admin player (in addition to memberID based auth)... multiple tags allowed
      #xml.adminip "???"
    
    when 'getDeletedRecordings' # For example when a user deletes his account. Gets called once an hour.
      #xml.memberID(user.id, :recordingname => 'Warum LIF', :status => 'all/approved/new')
    
    when 'getDomainPreferences'
      xml.allowCalls "getMemberID,notifyRecordingChange"
      xml.maxXMLRetries 10
      xml.maxrecordseconds 120
      xml.autoApprove false
      xml.sendRecordingListInterval 0 # How often (every X hours) the sendRecordingList method is called (0=never)
      #xml.noVideoimage "URL"
      #xml.videoNotEnabledImage "URL"
    
    when 'getMemberID' # (sessionGUID)
      if @user
        xml.memberID @user.id
        xml.admin (@user.is_admin)
        xml.videoEnabled true
        xml.audioKbps 22
        xml.videoKbps 200
        xml.videoFps 15
        xml.videoSize 2
        xml.webAccessible true
      else
        xml.memberID "INVALID"
      end
    
    when 'sendRecordingList' # (xmlData)
      # Used to verify our local DB is up to date
      # We chose to never call this above
      #  EXAMPLE:
			#	<?xml version='1.0' encoding='iso-8859-1'?>
			#	<recordingList>
			#		<member id="12345">
			#			<recording status="new"><![CDATA[profile]]></recording>
			#			<recording status="approved"><![CDATA[profile]]></recording>
			#			<recording status="approved"><![CDATA[messageTo_67890]]></recording>
			#		</member>
			#		<member id="67890">
			#			<recording status="approved"><![CDATA[profile]]></recording>
			#		</member>
			#	</recordingList>
    
  end
  
end
