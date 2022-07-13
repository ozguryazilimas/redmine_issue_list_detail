require_dependency 'queries_helper'

module RedmineIssueListDetail
  module Patches
    module QueriesHelperPatch

      def column_value(column, issue, value)
        return super unless column.name == :relations

        content_tag('span',
          value.to_s(issue) do |other|
            text = "##{other.id} (#{other.status})"
            title = other.subject.truncate(60)
            link_to(text, issue_url(other, :only_path => true), :class => other.css_classes, :title => title)
          end.html_safe,
          :class => value.css_classes_for(issue)
        )
      end

    end
  end
end

QueriesController.helper(RedmineIssueListDetail::Patches::QueriesHelperPatch)
IssuesController.helper(RedmineIssueListDetail::Patches::QueriesHelperPatch)

