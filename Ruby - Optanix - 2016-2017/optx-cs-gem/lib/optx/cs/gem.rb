require 'optx/cs/gem/version'
require 'mysql2'
require 'json'

# @todo : create table optx_Aws.ec2_object_def


module Optx

  # these variables can be used as Optx::BASE_URL, Optx::TIMEOUT
  $BASE_URL = ''
  $SECONDARY_DMZ_IP = ''
  $TIMEOUT = ''    

  $SAMPSON_DB = $SAMPSON_DB_SERVER = $SAMPSON_USER = $SAMPSON_PASSWORD = ''
  $STATUS_DB_SERVER = $STATUS_DB_NAME = $STATUS_DB_USER = $STATUS_DB_PASSWORD = ''
  $OBJECT_DB_SERVER = $OBJECT_DB_NAME = $OBJECT_DB_USER = $OBJECT_DB_PASSWORD = ''
  $LOG_DB_SERVER = $LOG_DB_NAME = $LOG_DB_USER = $LOG_DB_PASSWORD = ''
  $MRTG_DB_SERVER = $MRTG_DB_NAME = $MRTG_DB_USER = $MRTG_DB_PASSWORD =''
  $DECISION_ENGINE_DB_SERVER = $DECISION_ENGINE_DB_NAME = $DECISION_ENGINE_DB_USER = $DECISION_ENGINE_DB_PASSWORD = ''
  
  $sSYSTEM_TYPE = ''
  $sPRIMARY_IP = ''
  $sSECONDARY_IP = ''
  $sREDUNDANCY_IP = ''
  $sREDUNDANCY_ALIAS = ''
  $sDMZ_IP = ''
  $sSUPPORTSERVER = ''
  $sSUPPORTADDRESS = ''
  $sPUBLIC_KEY = ''
  $sTIMEZONE = ''
  $sREPORT_FROM_ADDRESS = ''
  $sStatusTableFormat = ''
  $sSiteName = ''

  $bNOTIFYSUPPORT = ''
  $bOPEN_THRESHOLD_CASE = ''
  $bEMAIL_THRESHOLD_NOTIFY = ''
  $bCriticalObjectStatus = ''
  $bConsolidateCaseNotifications = ''
  
  $iOBJ_INACTIVE = ''
  $iOBJ_MONITORED = ''
  $iOBJ_NON_MONITORED = ''
  $iStatusRefreshTimeout = ''
 
  $gsNOTIF_TEXT_FORMAT = ''
  $gsNOTIF_HTML_FORMAT = ''
  $gsNOTIF_NO_SUBJECT = ''
  $gsNOTIF_INCLUDE_SUBJECT = ''
  $gsNOTIF_SUPPRESS_SUBJECT = ''
  $gsNOTIF_PREFIX_ONLY_SUBJECT = ''
  $gsNOTIF_CONSOLIDATE = ''
  $gsDEFAULT_CASE_PRIORITY = ''

  $STATUS_TYPE_RAW = ''
  $STATUS_TYPE_DEPEND = ''
  $STATUS_TYPE_DECISION = ''
  $STATUS_TYPE_CASE = ''
  $STATUS_TYPE_OUTAGE = ''
  
  $STATUS_RAW_CRITICAL = ''
  $STATUS_RAW_NORMAL = ''
  
  $STATUS_DEPEND_CRITICAL = ''
  $STATUS_DEPEND_NORMAL = ''
  $STATUS_DEPEND_DEPEND_DOWN = ''
  
  $STATUS_DECISION_CRITICAL = ''
  $STATUS_DECISION_NORMAL = ''
  
  $STATUS_CASE_NONE = ''
  $STATUS_CASE_HIGH = ''
  $STATUS_CASE_MEDIUM = ''
  $STATUS_CASE_LOW = ''
  $STATUS_CASE_INFO = ''
  $STATUS_CASE_MONITOR_ONLY = ''
  
  $STATUS_OUTAGE_NORMAL = ''
  $STATUS_OUTAGE_ACTIVE = ''
  $STATUS_OUTAGE_ACTIVE = ''

 
  
  def self.initialize
     conn = Optx::get_connection('Main')
     Optx::getConfigParms(conn)
     
     $SAMPSON_DB_SERVER, $SAMPSON_USER, $SAMPSON_PASSWORD, $SAMPSON_DB = Optx::set_db_connection_params(conn, "Main")
     $STATUS_DB_SERVER, $STATUS_DB_USER, $STATUS_DB_PASSWORD, $STATUS_DB_NAME = Optx::set_db_connection_params(conn, "Status")
     $OBJECT_DB_SERVER, $OBJECT_DB_USER, $OBJECT_DB_PASSWORD, $OBJECT_DB_NAME = Optx::set_db_connection_params(conn, "Object")
     $LOG_DB_SERVER, $LOG_DB_USER, $LOG_DB_PASSWORD, $LOG_DB_NAME = Optx::set_db_connection_params(conn, "Log")
     $MRTG_DB_SERVER, $MRTG_DB_USER, $MRTG_DB_PASSWORD, $MRTG_DB_NAME = Optx::set_db_connection_params(conn, "MrtgData")
     $DECISION_ENGINE_DB_SERVER, $DECISION_ENGINE_DB_USER, $DECISION_ENGINE_DB_PASSWORD, $DECISION_ENGINE_DB_NAME = Optx::set_db_connection_params(conn, "DecisionEngine")
  end

  def getConfigParms(hDb)
     raise 'Database handle is required' unless hDb     
     res = hDb.query("SELECT parm, value FROM CaseSentryConfig")
     res.each do | row |
        $BASE_URL = row['value'] if (row['parm'] == 'BASE_URL')
        $sSYSTEM_TYPE = row['value'] if (row['parm'] == 'sSYSTEM_TYPE')
        $sPRIMARY_IP = row['value'] if (row['parm'] == 'sPRIMARY_IP')
        $sSECONDARY_IP = row['value'] if (row['parm'] == 'sSECONDARY_IP')
        $sREDUNDANCY_IP = row['value'] if (row['parm'] == 'sREDUNDANCY_IP')
        $sREDUNDANCY_ALIAS = row['value'] if (row['parm'] == 'sREDUNDANCY_ALIAS')
        $sDMZ_IP = row['value'] if (row['parm'] == 'sDMZ_IP')
        $SECONDARY_DMZ_IP = row['value'] if (row['parm'] == 'SECONDARY_DMZ_IP')
        $sSUPPORTSERVER = row['value'] if (row['parm'] == 'sSUPPORTSERVER')
        $bNOTIFYSUPPORT = row['value'] if (row['parm'] == 'bNOTIFYSUPPORT')
        $sSUPPORTADDRESS = row['value'] if (row['parm'] == 'sSUPPORTADDRESS')
        $bOPEN_THRESHOLD_CASE = row['value'] if (row['parm'] == 'bOPEN_THRESHOLD_CASE')
        $bEMAIL_THRESHOLD_NOTIFY = row['value'] if (row['parm'] == 'bEMAIL_THRESHOLD_NOTIFY')
        $sPUBLIC_KEY = row['value'] if (row['parm'] == 'sPUBLIC_KEY')
     end
  end
  
  def set_db_connection_params(hDb, sConnectionName)
    raise 'Database handle is required' unless hDb
    raise 'Database connection name is required' unless sConnectionName
    res = hDb.query("SELECT hostname, user, pw, db FROM db_logins WHERE name = #{sConnectionName}"
    res.fetch_row
  end
  
  def send_message(name, method, instance, message, extra_info, db)
    now = Time.now.to_i
    ms = Time.now.usec
    msg_id = "#{(now * 1000000) + ms}"

    sql = 'INSERT INTO `messages` (`msg_id`,`name`,`method`,`instance`,`message`,`extra_info`,`origin_host`) VALUES  ( ?, ?, ?, ?, ?, ?, ? ) '
    query = db.prepare(sql)
    query.execute(msg_id, name, method, instance, message, extra_info, Socket.gethostname)
  end

  def get_connection(handle = 'Main')
    json = File.read('/etc/CaseSentry/db_logins.conf')
    @confs = JSON.parse(json)
    begin
      #dbi = Mysql.new(@confs[handle]['hostname'], @confs[handle]['user'], @confs[handle]['pw'], @confs[handle]['db'])
      dbi = Mysql2::Client.new(
          :host => @confs[handle]['hostname'],
          :username => @confs[handle]['user'],
          :password => @confs[handle]['pw'],
          :database => @confs[handle]['db']
      )
    rescue Mysql2::Error => e
      puts e.inspect
      exit
    end
    dbi
  end

  def store_result(definition, data)
  end

  def device_exists?(name)
    conn = Optx::get_connection('Main')
    res = conn.query("SELECT id FROM object_def WHERE name='#{name}' AND method='GRP' and instance='NODE'")
    res.fetch_row
  end

  def map_instance_to_managed_device(instance: nil, managed_device: nil)
    conn = Optx::get_connection('Main')
    sql = 'SELECT object_def_name FROM ec2_object_def WHERE instance_id=?'
    query = conn.prepare(sql)
    res = query.execute(instance.to_s)
    res.fetch_row
  end

  def underscore(string)
    string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr('-', '_').
        downcase
  end

  def setCSConfigValue(hDb, sValue, sParam)
    raise 'Database handle is required' unless hDb
    raise 'Parameter name is required' unless sParam
    hDb.query("UPDATE CaseSentryConfig SET value = '#{sValue}' WHERE parm = '#{sParam}'")
    hDb.last_id
  end

  def getCSConfigValue(hDb, sParam, sParamGroup)
    raise 'Database handle is required' unless hDb
    raise 'Parameter name is required' unless sParam
    sql = "SELECT value FROM CaseSentryConfig WHERE parm = '#{sParam}' "
    # ruby perf tricks : http://greyblake.com/blog/2012/09/02/ruby-perfomance-tricks/
    sql << sParamGroup ? "AND parm_group = '#{sParamGroup}'" : "AND (ISNULL(parm_group) OR parm_group = '')"
    query = hDb.prepare(sql)
    res = query.execute()
    configvals = {}
    res.each do | row |
      configvals = row
    end
    configvals
  end

  extend self

  module Cs
    def setStatusTypeVariables(hDb)
      raise 'Database handle is required' unless hDb
      res = hDb.query("SELECT id, var_name FROM status_type")
      res.each do | row |
         case row['var_name']
             when 'STATUS_TYPE_RAW'
               $STATUS_TYPE_RAW = row['id']
             when 'STATUS_TYPE_DEPEND'
               $STATUS_TYPE_DEPEND = row['id']
             when 'STATUS_TYPE_DECISION'
               $STATUS_TYPE_DECISION = row['id']
             when 'STATUS_TYPE_CASE'
               $STATUS_TYPE_CASE = row['id']
             when 'STATUS_TYPE_OUTAGE'
               $STATUS_TYPE_OUTAGE = row['id']
             else
               Optx::Cs::Debugger::debug("setStatusTypeVariables - Unknown status type #{row['var_name']}")
         end
      end
    end

    def setStatusLevelInfoVariables(hDb)
      raise 'Database handle is required' unless hDb
      res = hDb.query("SELECT status_level, var_name FROM status_level")
      res.each do | row |
         case row['var_name']
             when 'STATUS_RAW_CRITICAL'
               $STATUS_RAW_CRITICAL = row['status_level']
             when 'STATUS_RAW_NORMAL'
               $STATUS_RAW_NORMAL = row['status_level']
             when 'STATUS_DEPEND_CRITICAL'
               $STATUS_DEPEND_CRITICAL = row['status_level']
             when 'STATUS_DEPEND_NORMAL'
               $STATUS_DEPEND_NORMAL = row['status_level']
             when 'STATUS_DEPEND_DEPEND_DOWN'
               $STATUS_DEPEND_DEPEND_DOWN = row['status_level']
             when 'STATUS_DECISION_CRITICAL'
               $STATUS_DECISION_CRITICAL = row['status_level']
             when 'STATUS_DECISION_NORMAL'
               $STATUS_DECISION_NORMAL = row['status_level']
             when 'STATUS_CASE_NONE'
               $STATUS_CASE_NONE = row['status_level']
             when 'STATUS_CASE_HIGH'
               $STATUS_CASE_HIGH = row['status_level']
             when 'STATUS_CASE_MEDIUM'
               $STATUS_CASE_MEDIUM = row['status_level']
             when 'STATUS_CASE_LOW'
               $STATUS_CASE_LOW = row['status_level']
             when 'STATUS_CASE_INFO'
               $STATUS_CASE_INFO = row['status_level']
             when 'STATUS_CASE_MONITOR_ONLY'
               $STATUS_CASE_MONITOR_ONLY = row['status_level']
             when 'STATUS_OUTAGE_NORMAL'
               $STATUS_OUTAGE_NORMAL = row['status_level']
             when 'STATUS_OUTAGE_ACTIVE'
               $STATUS_OUTAGE_ACTIVE = row['status_level']
             when 'STATUS_OUTAGE_ACTIVE'
               $STATUS_OUTAGE_ACTIVE = row['status_level']
             else
               Optx::Cs::Debugger::debug("setStatusLevelInfoVariables - Unknown status level #{row['var_name']}")
         end
      end
    end

    def get_creds_from_db(region)
      raise 'AWS region is required' unless region
      conn = Optx::get_connection('Main')  #Main has the same connection data as Optx_Aws, so this works (today)
      res = conn.query("SELECT access_key,secret_key FROM Optx_Aws.credentials WHERE region='#{region}'")
      creds = {}
      res.each do | row |
        creds = row
      end
      creds
    end

    def store_creds(region, access_key, secret_key)
      raise 'AWS region is required' unless region
      raise 'AWS access key is required' unless access_key
      raise 'AWS secret key is required' unless secret_key
      conn = Optx::get_connection('Main')
      sql = 'REPLACE INTO Optx_Aws.credentials ( `region`,`access_key`,`secret_key`) VALUES ( ?, ?, ? )'
      query = conn.prepare(sql)
      res = query.execute(region, access_key, secret_key)
      query.last_id
    end

    def evaluate_alarm(alarm)
      return alarm.state_value == 'OK' ? 1 : 0
    end

    def defined_alarm?(alarm, db)
      raise 'Alarm name is required' unless alarm
      conn = Optx::get_connection('Main')
      rs = conn.query("SELECT IF(instance,1,0) as 'b' FROM Optx_Aws.cw_defined_alarms WHERE alarm_name='#{alarm}'")
      rs.each do | row |
        unless row[b] == 0
          TRUE
        end
        FALSE
      end
    end

    extend self

    module Gem
      # Ycode goes here...
    end
  end
end