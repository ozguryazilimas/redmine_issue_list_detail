require_dependency 'queries_helper'

module RedmineIssueListDetail
  module Patches
    module QueriesHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :column_value, :redmine_issue_list_detail
        end
      end

      module InstanceMethods

        def column_value_with_redmine_issue_list_detail(column, issue, value)
          return column_value_without_redmine_issue_list_detail(column, issue, value) unless column.name == :relations

          content_tag('span',
            value.to_s(issue) do |other|
              text = "##{other.id} (#{other.status})"
              title = other.subject.truncate(60)
              link_to(text, issue_url(other, :only_path => true), :class => other.css_classes, :title => title)
            end.html_safe,
            :class => value.css_classes_for(issue))
        end

      end

    end
  end
end

