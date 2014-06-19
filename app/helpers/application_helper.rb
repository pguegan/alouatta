module ApplicationHelper

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile'

  def is_mobile_device?(user_agent = request.user_agent)
    !!(user_agent.to_s.downcase =~ Regexp.new(MOBILE_USER_AGENTS))
  end

  def is_autoplay_device?(user_agent = request.user_agent)
    !(user_agent.to_s.downcase =~ Regexp.new('ipod|iphone|android'))
  end

  def is_volume_capable?(user_agent = request.user_agent)
    !(user_agent.to_s.downcase =~ Regexp.new('ipod|iphone|ipad'))
  end

end
