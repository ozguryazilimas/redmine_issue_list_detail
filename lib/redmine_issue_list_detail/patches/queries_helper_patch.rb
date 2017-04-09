require_dependency 'queries_helper'

module RedmineIssueListDetail
  module Patches
    module QueriesHelperPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          alias_method_chain :column_value, :redmine_issue_list_detail
        end
      end

      module ClassMethods

      end

      module InstanceMethods

        def column_value_with_redmine_issue_list_detail(column, issue, value)
          return column_value_without_redmine_issue_list_detail(column, issue, value) unless column.name == :relations

          content_tag('span',
            value.to_s(issue) {|other| rild_link_to_issue_with_status(other)}.html_safe,
            :class => value.css_classes_for(issue))
        end

        private

        def rild_link_to_issue_with_status(issue)
          text = "##{issue.id} (#{issue.status})"
          title = issue.subject.truncate(60)

          link_to(text, issue_url(issue, :only_path => true), :class => issue.css_classes, :title => title)
        end
      end

    end
  end
end

