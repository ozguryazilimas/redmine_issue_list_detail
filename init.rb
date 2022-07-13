require 'redmine'

Redmine::Plugin.register :redmine_issue_list_detail do
  name 'Redmine Issue List Detail plugin'
  author 'Onur Kucuk'
  description 'Redmine plugin to format issue list'
  version '1.1.0'
  url 'http://www.ozguryazilim.com.tr'
  author_url 'http://www.ozguryazilim.com.tr'
  requires_redmine :version_or_higher => '4.0.0'
end

Rails.configuration.to_prepare do
  [
    [QueriesHelper, RedmineIssueListDetail::Patches::QueriesHelperPatch]
  ].each do |classname, modulename|
    unless classname.included_modules.include?(modulename)
      classname.send(:include, modulename)
    end
  end

end

